﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// (с) Tolkachev Pavel, 2020 - 2022
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает ссылку на общий клиентский модуль.
//
// Параметры:
//  Имя - Строка - имя общего клиентского модуля.
//
// Возвращаемое значение:
//  Общий клиентский модуль.
//
Функция ОбщийМодуль(Имя) Экспорт
	
	Возврат Вычислить(Имя);
	
КонецФункции

// Возвращает ссылка на модуль формы.
//
// Параметры:
//  ТипОбъекта - Строка - тип объекта ("ОбщаяФорма", "Справочник", "Отчет" и т.п.).
//  ИмяОбъекта - Строка - имя объекта ("ФормаВводаАдреса", "Номенклатура", "Продажи" и т.п.).
//  ИмяФормы - Строка - имя формы для объекта, имеющего несколько форм (справочник, документ и т.п.).
// 
// Возвращаемое значение:
//  Модуль формы.
//
// Примеры использования.
//	МодульОбщейФормы = МодульФормы("ОбщаяФорма", "ФормаВводаАдреса");
//	МодульФормыНоменклатуры = МодульФормы("Справочник", "Номенклатура", "ФормаЭлемента");
//
Функция МодульФормы(ТипОбъекта, ИмяОбъекта, ИмяФормы = Неопределено) Экспорт
	
	ПолноеИмяФормы = ТипОбъекта + "." + ИмяОбъекта + ?(ИмяФормы = Неопределено, "", ".Форма." + ИмяФормы);
	
	ПараметрыФормы = Новый Структура("АвтоТест", Истина);
	МодульФормы = ПолучитьФорму(ПолноеИмяФормы, ПараметрыФормы);
	
	Возврат МодульФормы;
	
КонецФункции 

// Читает настройки тестирования в глобальную переменную и,
// при необходимости, выполняет автоматический запуск тестов.
//
Процедура ПрочитатьНастройкиТестированияИВыполнитьАвтозапускТестов() Экспорт
	Перем ВыполнитьАвтозапускТестов;
	
	глНастройкиТестирования = мт_ТестированиеСлужебныйВызовСервера.ПриНачалеРаботыПрочитатьНастройкиТестирования(
		ВыполнитьАвтозапускТестов);
	
	Если ТипЗнч(глНастройкиТестирования) <> Тип("Структура") Тогда
		глНастройкиТестирования = мт_ТестированиеСлужебныйКлиентПовтИсп.НастройкиТестированияПоУмолчанию();
	КонецЕсли; 
	
	Если ВыполнитьАвтозапускТестов Тогда
		ПараметрыФормы = Новый Структура("Автозапуск", Истина);
		ОткрытьФорму("Обработка.мт_МодульноеТестирование.Форма", ПараметрыФормы);
	КонецЕсли; 
	
КонецПроцедуры 

#КонецОбласти