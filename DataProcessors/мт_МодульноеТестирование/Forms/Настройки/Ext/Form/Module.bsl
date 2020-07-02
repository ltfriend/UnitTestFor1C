﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// (с) Tolkachev Pavel, 2020
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

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли; 
	
	АвтоматическийЗапускПриНачалеРаботы = Параметры.АвтоматическийЗапускПриНачалеРаботы;
	КаталогЖурнала = Параметры.КаталогЖурнала;
	ПользовательДляАвтоЗапускаТестов = Параметры.ПользовательДляАвтоЗапускаТестов;
	СохранятьРезультаты = Параметры.СохранятьРезультаты;
	ЗавершатьРаботуПослеАвтозапуска = Параметры.ЗавершатьРаботуПослеАвтозапуска;
	
	УправлениеДоступностью(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Не Модифицированность Тогда
		Возврат;
	КонецЕсли; 
	
	Отказ = Истина;
	
	Если ЗавершениеРаботы Тогда
		ТекстПредупреждения = НСтр("ru='Изменения настроек тестирования будут утеряны.'");
	Иначе
		ТекстВопроса = НСтр("ru='Настройки были изменены. Сохранить изменения?'");
		Оповещение = Новый ОписаниеОповещения("ВопросСохранитьНастройкиЗавершение", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросСохранитьНастройкиЗавершение(Ответ, ДопПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		СохранитьНастройки();
	ИначеЕсли Ответ = КодВозвратаДиалога.Нет Тогда
		ОтменитьИзменения();
	Иначе
		// Ни каких действий выполнять не требуется.
	КонецЕсли; 
	
КонецПроцедуры 

#КонецОбласти 

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура СохранятьРезультатыПриИзменении(Элемент)
	
	УправлениеДоступностью(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура АвтоматическийЗапускПриНачалеРаботыПриИзменении(Элемент)
	
	УправлениеДоступностью(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогЖурналаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбора.Заголовок = НСтр("ru='Укажите каталог для сохранения результатов тестов'");
	ДиалогВыбора.Каталог = КаталогЖурнала;
	
	Оповещение = Новый ОписаниеОповещения("ВыборКаталогаЖурналаЗавершение", ЭтотОбъект);
	ДиалогВыбора.Показать(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборКаталогаЖурналаЗавершение(ВыбранныеФайлы, ДопПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		КаталогЖурнала = ВыбранныеФайлы[0];
		Модифицированность = Истина;
	КонецЕсли; 
	
КонецПроцедуры 

&НаКлиенте
Процедура КаталогЖурналаОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Не ЗначениеЗаполнено(КаталогЖурнала) Тогда
		Возврат;
	КонецЕсли; 
	
	Оповещение = Новый ОписаниеОповещения("ПроверитьСуществованиеКаталогаЖурналаЗавершение", ЭтотОбъект);
	
	Файл = Новый Файл(КаталогЖурнала);
	Файл.НачатьПроверкуСуществования(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСуществованиеКаталогаЖурналаЗавершение(Существует, ДопПараметры) Экспорт
	
	Если Существует Тогда
		НачатьЗапускПриложения(Новый ОписаниеОповещения, КаталогЖурнала);
	КонецЕсли; 
	
КонецПроцедуры 

&НаКлиенте
Процедура ПользовательДляАвтоЗапускаТестовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СписокПользователей = ПолучитьПользователейИБ();
	
	Оповещение = Новый ОписаниеОповещения("ВыборПользователяДляАвтоЗапускаТестовЗавершение", ЭтотОбъект);
	СписокПользователей.ПоказатьВыборЭлемента(Оповещение, НСтр("ru='Пользователи'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборПользователяДляАвтоЗапускаТестовЗавершение(ВыбранныйЭлемент, ДопПараметры) Экспорт
	
	Если ВыбранныйЭлемент <> Неопределено Тогда
		ПользовательДляАвтоЗапускаТестов = ВыбранныйЭлемент.Значение;
	КонецЕсли; 
	
КонецПроцедуры 

#КонецОбласти 

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СохранитьНастройки(Команда = Неопределено)
	
	Отказ = Ложь;
	
	Если СохранятьРезультаты И ПустаяСтрока(КаталогЖурнала) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Поле = "КаталогЖурнала";
		Сообщение.Текст = НСтр("ru='Не указан каталог для сохранения результатов тестов.'");
		Сообщение.Сообщить();
		
		Отказ = Истина;
	КонецЕсли; 
	
	Если АвтоматическийЗапускПриНачалеРаботы И ПустаяСтрока(ПользовательДляАвтоЗапускаТестов) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Поле = "ПользовательДляАвтоЗапускаТестов";
		Сообщение.Текст = НСтр("ru='Не указан пользователя для автоматического запуска тестов.'");
		Сообщение.Сообщить();
		
		Отказ = Истина;
	КонецЕсли; 
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли; 
	
	Настройки = Новый Структура(
		"АвтоматическийЗапускПриНачалеРаботы,
		|КаталогЖурнала,
		|ПользовательДляАвтоЗапускаТестов,
		|СохранятьРезультаты,
		|ЗавершатьРаботуПослеАвтозапуска");
	ЗаполнитьЗначенияСвойств(Настройки, ЭтотОбъект);
	
	Модифицированность = Ложь;
	Закрыть(Настройки);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьИзменения(Команда = Неопределено)
	
	Модифицированность = Ложь;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеДоступностью(Форма)
	
	Элементы = Форма.Элементы;
	
	Элементы.КаталогЖурнала.Доступность = Форма.СохранятьРезультаты;
	Элементы.ПользовательДляАвтоЗапускаТестов.Доступность = Форма.АвтоматическийЗапускПриНачалеРаботы;
	Элементы.ЗавершатьРаботуПослеАвтозапуска.Доступность = Форма.АвтоматическийЗапускПриНачалеРаботы;
	
КонецПроцедуры 

&НаСервереБезКонтекста
Функция ПолучитьПользователейИБ()
	
	СписокПользователей = Новый СписокЗначений;
	ПользователиИБ = ПользователиИнформационнойБазы.ПолучитьПользователей();
	
	Для каждого Пользователь Из ПользователиИБ Цикл
		СписокПользователей.Добавить(Пользователь.Имя);
	КонецЦикла;
	
	Возврат СписокПользователей;
	
КонецФункции 

#КонецОбласти 