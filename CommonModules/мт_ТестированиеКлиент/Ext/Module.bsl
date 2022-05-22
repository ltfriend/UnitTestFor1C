///////////////////////////////////////////////////////////////////////////////////////////////////////
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

// Имитирует выбор пользователем значения в поле формы. Для выбора используется процедура ОповеститьОВыборе формы
// клиентского приложения.
//
// Параметры:
//  Элемент - элемент формы (или сама форма), выбор в котором необходимо имитировать.
//  ВыбранноеЗначение - Произвольный - значение, выбор которого имитируется. Данное значение будет подставленно в
//                                     указанный элемент формы. Если в качестве элемента указан тип
//                                     ФормаКлиентскогоПриложения или ТаблицаФормы, то будет вызван обработчик
//                                     ОбработкаВыбора.
//
Процедура ИмитироватьВыборВПолеФормы(Элемент, ВыбранноеЗначение) Экспорт
	
	ФормаВыбора = ПолучитьФорму("ОбщаяФорма.мт_СлужебнаяФорма", , Элемент);
	ФормаВыбора.ОповеститьОВыборе(ВыбранноеЗначение);
	
КонецПроцедуры 

#КонецОбласти