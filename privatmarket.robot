*** Settings ***
#Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  Selenium2Library
Library  Collections
Library  DebugLibrary
Library  privatmarket_service.py

*** Variables ***
${COMMONWAIT}	40s

${tender_data_title}	xpath=//div[contains(@class,'title-div')]
${tender_data_description}	id=tenderDescription
${tender_data_procurementMethodType}	id=tenderType
${tender_data_status}	id=tenderStatus
${tender_data_value.amount}	id=tenderBudget
${tender_data_value.currency}	id=tenderBudgetCcy
${tender_data_value.valueAddedTaxIncluded}	id=tenderBudgetTax
${tender_data_tenderID}	id=tenderId
${tender_data_procuringEntity.name}	css=a[ng-click='commonActions.openCard()']
${tender_data_enquiryPeriod.startDate}	xpath=(//span[@ng-if='p.bd'])[1]
${tender_data_enquiryPeriod.endDate}	xpath=(//span[contains(@ng-if, 'p.ed')])[1]
${tender_data_tenderPeriod.startDate}	xpath=(//span[@ng-if='p.bd'])[2]
${tender_data_tenderPeriod.endDate}	xpath=(//span[contains(@ng-if, 'p.ed')])[2]
${tender_data_auctionPeriod.startDate}	xpath=(//span[@ng-if='p.bd'])[3]
${tender_data_minimalStep.amount}	css=div#lotMinStepAmount
${tender_data_documentation.title}	xpath=//div[@class="file-descriptor"]/span[1]
${tender_data_items.description}	xpath=//a[contains(@ng-click, 'adb.showCl = !adb.showCl')]
${tender_data_items.deliveryDate.startDate}	xpath=//div[@ng-if='adb.deliveryDate.startDate']/div[2]
${tender_data_items.deliveryDate.endDate}	xpath=//div[@ng-if='adb.deliveryDate.endDate']/div[2]
${tender_data_items.deliveryLocation.latitude}	css=span.latitude
${tender_data_items.deliveryLocation.longitude}	css=span.longitude
${tender_data_items.deliveryAddress.countryName}	css=span#countryName
${tender_data_items.deliveryAddress.postalCode}	css=span#postalCode
${tender_data_items.deliveryAddress.region}	css=span#region
${tender_data_items.deliveryAddress.locality}	css=span#locality
${tender_data_items.deliveryAddress.streetAddress}	css=span#streetAddress
${tender_data_items.classification.scheme}	xpath=//div[@ng-if="adb.classification"]
${tender_data_items.classification.id}	xpath=//div[@ng-if="adb.classification"]
${tender_data_items.classification.description}	xpath=//div[@ng-if="adb.classification"]
${tender_data_items.additionalClassifications[0].scheme}	xpath=//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_items.additionalClassifications[0].id}	xpath=//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_items.additionalClassifications[0].description}	xpath=//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_items.unit.name}	xpath=//div[@ng-if='adb.quantity']/div[2]/span[2]
${tender_data_items.unit.code}	xpath=//div[@ng-if='adb.quantity']/div[2]/span[2]
${tender_data_items.quantity}	xpath=//div[@ng-if='adb.quantity']/div[2]/span

${tender_data_item.description}	//div[@class="description"]//span
${tender_data_item.deliveryDate.endDate}	div[@ng-if='adb.deliveryDate.endDate']/div[2]
${tender_data_item.deliveryLocation.latitude}	css=span.latitude
${tender_data_item.deliveryLocation.longitude}	css=span.longitude
${tender_data_item.deliveryAddress.countryName}	css=span#countryName
${tender_data_item.deliveryAddress.postalCode}	css=span#postalCode
${tender_data_item.deliveryAddress.region}	css=span#region
${tender_data_item.deliveryAddress.locality}	css=span#locality
${tender_data_item.deliveryAddress.streetAddress}	css=span#streetAddress
${tender_data_item.classification.scheme}	//div[@ng-if="adb.classification"]
${tender_data_item.classification.id}	//div[@ng-if="adb.classification"]
${tender_data_item.classification.description}	//div[@ng-if="adb.classification"]
${tender_data_item.additionalClassifications[0].scheme}	//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_item.additionalClassifications[0].id}	//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_item.additionalClassifications[0].description}	//div[@ng-repeat='cl in adb.additionalClassifications'][1]
${tender_data_item.unit.name}	//div[@ng-if='adb.quantity']/div[2]/span[2]
${tender_data_item.unit.code}	//div[@ng-if='adb.quantity']/div[2]/span[2]
${tender_data_item.quantity}	//div[@ng-if='adb.quantity']/div[2]/span

${tender_data_question.title}	//span[contains(@class, 'question-title')]
${tender_data_question.description}	//div[@class='question-div']/div[1]
${tender_data_question.answer}	//div[@class='question-div question-expanded']/div[1]
${tender_data_question.questions[0].description}	css=div.question-div
${tender_data_question.questions[0].date}	xpath=//div[@class = 'question-head title']/b[2]
${tender_data_question.questions[0].title}	css=div.question-head.title span
${tender_data_question.questions[0].answer}	xpath=//div[@ng-if='q.answer']//div[@class='ng-binding']
${tender_data_question.questions.questions[0].answer}	xpath=//div[@ng-if='q.answer']//div[@class='ng-binding']
${tender_data_question.questions.questions[0].description}	css=div.question-div
${tender_data_question.questions.questions[0].date}	xpath=//div[@class = 'question-head title']/b[2]
${tender_data_question.questions.questions[0].title}	css=div.question-head.title span
${tender_data_question.questions.questions[0].answer}	xpath=//div[@ng-if='q.answer']//div[@class='ng-binding']

${tender_data_lots.classification.scheme}	css=.cl-scheme.ng-binding
${tender_data_lots.classification.id}	css=.cl-id.ng-binding
${tender_data_lots.classification.description}	css=.cl-name.ng-binding
${tender_data_lots.additionalClassifications[0].scheme}	css=.cl-scheme.ng-binding
${tender_data_lots.additionalClassifications[0].id}	css=.cl-id.ng-binding
${tender_data_lots.additionalClassifications[0].description}	css=.cl-name.ng-binding
${tender_data_lots.quantity}	css=.item-count.ng-binding

${tender_data_questions[0].description}	css=div.question-div
${tender_data_questions[0].date}	xpath=//div[@class = 'question-head title']/b[2]
${tender_data_questions[0].title}	css=div.question-head.title span
${tender_data_questions[0].answer}	xpath=//div[@ng-if='q.answer']//div[@class='ng-binding']
${tender_data_lot.title}  //div[@id='lot-title']
#${tender_data_lot.minimalStep.amount}  //div[@id='lotMinStepAmount']
#${tender_data_lot.minimalStep.currency}	css=#lotMinStepCcy
#${tender_data_lot.minimalStep.valueAddedTaxIncluded}	css=#lotMinStepCcy
${tender_data_lots.minimalStep.amount}	css=#lotMinStepAmount
${tender_data_lots.minimalStep.currency}	css=#lotMinStepCcy
${tender_data_lots.minimalStep.valueAddedTaxIncluded}	css=#lotMinStepTax
#${tender_data_lot.lots.minimalStep.amount}	css=#lotMinStepAmount
#${tender_data_lot.lots.minimalStep.currency}	css=#lotMinStepCcy
#${tender_data_lot.lots.minimalStep.valueAddedTaxIncluded}	css=#lotMinStepTax

${tender_data_lots.title}	css=#lot-title
${tender_data_lots.description}	css=.description.marged.ng-binding

${tender_data_lots.value.amount}	css=#lotAmount
${tender_data_lots.value.currency}	css=#lotCcy
${tender_data_lots.value.valueAddedTaxIncluded}	css=#lotTax
#${tender_data_lots.lots.minimalStep.amount}	css=#lotMinStepAmount
#${tender_data_lots.lots.minimalStep.currency}	css=#lotMinStepCcy
#${tender_data_lots.lots.minimalStep.valueAddedTaxIncluded}	css=#lotMinStepTax
#${tender_data_lots.lots.title}	css=#lot-title
#${tender_data_lots.lots.description}	css=.description.marged.ng-binding
#${tender_data_lots.lots.value.amount}	css=#lotAmount
#${tender_data_lots.lots.lotMinStepAmount}	css=#lotMinStepAmount
#${tender_data_lots.lots.lotMinStepCurrency}	css=#lotMinStepCcy
#${tender_data_lots.lots.lotMinStepAddedTaxIncluded}	css=#lotMinStepTax
#${tender_data_lots.lots[0].minimalStep.amount}	css=#lotMinStepAmount
#${tender_data_lots.lots[0].minimalStep.currency}	css=#lotMinStepCcy
#${tender_data_lots.lots[0].minimalStep.valueAddedTaxIncluded}	css=#lotMinStepTax
${tender_data_bids}	xpath=(//table[@class='bids']//tr)[2]
${tender_data_cancellations[0].status}	xpath=//*[@id='nolotSection']/div[1]/div[1]
${tender_data_cancellations[0].reason}	xpath=//*[@id='nolotSection']/div[1]/div[2]
${tender_data_cancellations[0].documents[0].title}	css=.file-name.ng-binding
${tender_data_title_en}	css=.title-div.ng-binding
${tender_data_title_ru}	css=.title-div.ng-binding
${tender_data_title_ua}	css=.title-div.ng-binding
${tender_data_description_en}	css=#tenderDescription
${tender_data_description_ru}	css=#tenderDescription
${tender_data_description_ua}	css=#tenderDescription
${tender_data_procuringEntity.address.countryName}	css=#procurerAddr #countryName
${tender_data_procuringEntity.address.locality}	css=#procurerAddr #locality
${tender_data_procuringEntity.address.postalCode}	css=#procurerAddr #postalCode
${tender_data_procuringEntity.address.region}	css=#procurerAddr #region
${tender_data_procuringEntity.address.streetAddress}	css=#procurerAddr #streetAddress
${tender_data_procuringEntity.contactPoint.name}	xpath=//div[@class='delivery-info']/div[2]/div[@class='info-item-val ng-binding']
${tender_data_procuringEntity.contactPoint.telephone}	xpath=//div[@class='delivery-info']/div[4]/div[@class='info-item-val ng-binding']
${tender_data_procuringEntity.contactPoint.url}	xpath=//div[@class='delivery-info']/div[5]/div[@class='info-item-val ng-binding']
${tender_data_procuringEntity.identifier.legalName}	xpath=//div[@id='procurerLegalName']/div[2]
${tender_data_procuringEntity.identifier.scheme}	xpath=//div[@id='procurerId']/div[1]
${tender_data_procuringEntity.identifier.id}	xpath=//div[@id='procurerId']/div[2]
${tender_data_causeDescription}	css=#tenderType>div
${complaints[0].title}	xpath=(//div[@class='title']/span)[1]
${complaints[0].description}	xpath=(//div[@ng-bind-html='q.description'])[1]
${complaints[0].documents.title}	xpath=(//span[@class='file-name'])[1]
${complaints[0].status}	xpath=(//div[contains(@ng-if,'q.status')])[1]
${locator_tender.switchToDemo}	css=a#test-model-switch
${locator_tender.switchToDemo.message}	css=.test-mode-popup-content.ng-binding
${locator_tenderCreation.buttonEdit}	xpath=//button[@ng-click='act.createAfp()']
${locator_tenderCreation.buttonSend}	css=button[data-id='actSend']
${locator_tenderCreation.buttonSave}	css=button.btn.btn-success
${locator_tenderCreation.buttonBack}	xpath=//a[@ng-click='act.goBack()']
${locator_tenderCreation.description}	css=textarea[ng-model='model.filterData.adbName']
${locator_tenderClaim.buttonCreate}	css=button[ng-click='commonActions.createAfp()']
${locator_tenderClaim.fieldPrice}	css=input[ng-model='model.userPrice']
${locator_tenderClaim.checkedLot.fieldPrice}	xpath=//input[@ng-model='model.checkedLot.userPrice']
${locator_tenderClaim.fieldEmail}	css=input[ng-model='model.person.email']
${locator_tenderClaim.buttonSend}	css=button[ng-click='act.sendAfp()']
${locator_tenderClaim.buttonCancel}	css=a[ng-click='act.delAfp()']
${locator_tenderClaim.buttonGoBack}	css=a[ng-click='act.ret2Ad()']
${locator_tender.ajax_overflow}	xpath=//div[@class='ajax_overflow']
${locator_tenderSearch.searchInput}	css=input#search-query-input
${locator_tenderSearch.tendersList}	css=tr[ng-repeat='t in model.tenderList']
${locator_tenderSearch.addTender}	css=button[ng-click='template.newTender()']
${locator_tenderAdd.tenderType}	xpath=(//div[@class='big-button-step'])[1]
${locator_tenderAdd.procurementName}	css=input[data-id='procurementName']
${locator_tenderAdd.procurementDescription}	css=textarea[data-id='procurementDescription']
${locator_tenderAdd.procurementClassifications}	xpath=(//span[@data-id='actChoose'])[1]
${locator_tenderAdd.btnSave}	css=button[data-id='actSave']
${locator_tenderAdd.firstTab}	css=#tab_1 a
${locator_tenderAdd.firstTab}	css=#tab_2 a
${locator_tenderAdd.thirdTab}	css=#tab_3 a
${locator_tenderAdd.docs.yes}	css=label[for='documentation_tender_yes']
${locator_tenderAdd.docs.loader}	css=div.file-loader a
${locator_tenderAdd.docs.fileTitle}	css=div[ng-if="!model.file.title"]

${locator_lotAdd.description}	css=input[ng-model='item.description']
${locator_lotAdd.quantity}	css=input[data-id='quantity']
${locator_lotAdd.adressType}	xpath=//input[contains(@ng-model, 'item.adressTypeMode')][1]
${locator_lotAdd.postalCode}	css=input[data-id='postalCode']
${locator_lotAdd.countryName}	css=input[data-id='countryName']
${locator_lotAdd.region}	css=input[data-id='region']
${locator_lotAdd.locality}	css=input[data-id='locality']
${locator_lotAdd.streetAddress}	css=input[data-id='streetAddress']
${locator_lotAdd.deliveryEndDate}	css=input[ng-model='item.deliveryDate.ed.d']

${locator_tenderInfo.lotDescriptionBtn}	xpath=//li[contains(@ng-class, 'description')]
${locator_tenderInfo.lotDescriptionBody}	xpath=//section[@class='description marged ng-binding']
${locator_tender.complaint.btnSave}	id=btnSaveComplaint

${locator_question.create}	xpath=//div[@class='delivery-info ng-scope']/div/a[@ng-click='act.sendEnquiry()']
${locator_question.title}	xpath=//input[@ng-model="model.question.title"]
${locator_question.description}	xpath=//textarea[@ng-model='model.question.description']
${locator_question.usersEmail}	id=personEmail
${locator_question.country}	id=addressCountry
${locator_question.postalCode}	id=addressPostalCode
${locator_question.region}	id=addressRegion
${locator_question.locality}	id=addressLocality
${locator_question.street}	id=addressStreet
${locator_question.sendQuestion}	xpath=//button[@ng-click='act.sendQuestion()']
${locator_question.hideModal}	css=span[ng-click='act.hideModal()']

${locator_tender.bid.BtnNext}	css=button[ng-click='commonActions.goNext(1)']

${keywords}  /op_robot_tests/tests_files/keywords

*** Keywords ***
Підготувати дані для оголошення тендера
	[Arguments]  ${username}  ${tender_data}  ${role_name}
	${tender_data.data} = 	Run Keyword If	'PrivatMarket_Owner' == '${username}'	modify_test_data	${tender_data.data}
	${adapted.data} = 	modify_test_data	${tender_data.data}
	[Return]  ${tender_data}


Підготувати клієнт для користувача
	[Arguments]  ${username}
	[Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо

	${browser} =		Convert To Lowercase	${USERS.users['${username}'].browser}

	${prefs}  Create Dictionary  download.default_directory=${OUTPUT_DIR}
	${chrome_options}= 	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
	Call Method	${chrome_options}		add_experimental_option	prefs	${prefs}

    #Для Viewer'а нужен хром, т.к. на хром настроена автоматическая закачка файлов
	Run Keyword If  '${username}' == 'PrivatMarket_Viewer'	Create WebDriver	Chrome	chrome_options=${chrome_options}	alias=${username}
	Run Keyword If  '${username}' == 'PrivatMarket_Owner'	Create WebDriver	Firefox	alias=${username}
	Run Keyword If  '${username}' == 'PrivatMarket_Provider'	Create WebDriver	Chrome	chrome_options=${chrome_options}	alias=${username}
	Go To	${USERS.users['${username}'].homepage}

#	Open Browser	${USERS.users['${username}'].homepage}	${browser}	alias=${username}

	Set Window Size	@{USERS.users['${username}'].size}
	Set Selenium Implicit Wait	10s
	Login	${username}
	Switch To PMFrame


Пошук тендера по ідентифікатору
	[Arguments]  ${username}  ${tenderId}
	Go To	${USERS.users['${username}'].homepage}
	Close notification
#	Chose UK language
	Wait Until Element Is Visible	${locator_tenderSearch.searchInput}	timeout=${COMMONWAIT}
#	Wait Until Element Is Enabled	${locator_tenderSearch.tendersList}	timeout=${COMMONWAIT}

	${suite_name} = 	Convert To Lowercase	${SUITE_NAME}
	${education_type} =	Run Keyword If	'negotiation' in '${suite_name}'	Set Variable	False
		...  ELSE	Set Variable	True

	Wait For Tender	${tenderId}	${education_type}
	Wait Visibility And Click Element	css=tr#${tenderId}
	Sleep  5s
	Switch To PMFrame
	Wait Until Element Is Visible	${tender_data_title}	${COMMONWAIT}


Створити тендер
	[Arguments]  ${username}  ${tender_data}
	${presence} = 	Run Keyword And Return Status	List Should Contain Value	${tender_data.data}	lots
	@{lots} = 		Run Keyword If	${presence}		Get From Dictionary	${tender_data.data}	lots
	${presence} = 	Run Keyword And Return Status	List Should Contain Value	${tender_data.data}	items
	@{items} = 		Run Keyword If	${presence}		Get From Dictionary	${tender_data.data}	items
	${presence} = 	Run Keyword And Return Status	List Should Contain Value	${tender_data.data}	features
	@{features} = 	Run Keyword If	${presence}		Get From Dictionary	${tender_data.data}	features
	Switch To PMFrame
	Close notification
#	Chose UK language
	Wait Until Element Is Visible	${locator_tenderSearch.searchInput}	${COMMONWAIT}
#	Wait Until Element Is Enabled	${locator_tenderSearch.tendersList}	${COMMONWAIT}
#	Check Current Mode
	Check Current Mode New Realisation
#go to form
	Wait Visibility And Click Element	${locator_tenderSearch.addTender}
#    Wait Until Element Is Visible  css=#sender-analytics  ${COMMONWAIT}
    Unselect Frame
    Wait Until Page Contains Element  id=sender-analytics  ${COMMONWAIT}
    Switch To PMFrame
	Wait Visibility And Click Element	${locator_tenderAdd.tenderType}
#step 0
	#we should add choosing of procurementMethodType
	Switch To PMFrame
	Wait Element Visibility And Input Text	${locator_tenderAdd.procurementName}	${tender_data.data.title}
	Wait Element Visibility And Input Text	${locator_tenderAdd.procurementDescription}	${tender_data.data.description}

	#CPV
	Wait Visibility And Click Element	${locator_tenderAdd.procurementClassifications}
	Wait Until Element Is Visible	css=section[data-id='classificationTreeModal']	${COMMONWAIT}
	Wait Until Element Is Visible	css=input[data-id='query']	${COMMONWAIT}
	Search By Query	css=input[data-id='query']	${items[0].classification.id}
	Wait Visibility And Click Element	css=button[data-id='actConfirm']
	Run Keyword If  '${items[0].classification.id}' == '99999999-9'  Обрати додаткові класифікатори   ${items[0].additionalClassifications[0].scheme}   ${items[0].additionalClassifications[0].id}

	#date
	Switch To PMFrame
	Wait Until Element Is Visible	css=input[ng-model='model.ptr.enquiryPeriod.sd.d']	${COMMONWAIT}
	Set Date And Time	enquiryPeriod	startDate	css=span[data-id='ptrEnquiryPeriodStartDate'] input[ng-model='inputTime']	${tender_data.data.enquiryPeriod.startDate}
	Wait Until Element Is Visible	css=span[data-id='ptrEnquiryPeriodEndDate'] input[ng-model='inputTime']	${COMMONWAIT}
	Set Date And Time	enquiryPeriod	endDate	css=span[data-id='ptrEnquiryPeriodEndDate'] input[ng-model='inputTime']	${tender_data.data.enquiryPeriod.endDate}
	Wait Until Element Is Visible	css=span[data-id='ptrTenderPeriodStartDate'] input[ng-model='inputTime']	${COMMONWAIT}
	Set Date And Time	tenderPeriod	startDate	css=span[data-id='ptrTenderPeriodStartDate'] input[ng-model='inputTime']	${tender_data.data.tenderPeriod.startDate}
	Wait Until Element Is Visible	css=span[data-id='ptrTenderPeriodEndDate'] input[ng-model='inputTime']	${COMMONWAIT}
	Set Date And Time	tenderPeriod	endDate	css=span[data-id='ptrTenderPeriodEndDate'] input[ng-model='inputTime']	${tender_data.data.tenderPeriod.endDate}

	#procuringEntityAddress
	Wait Element Visibility And Input Text	${locator_lotAdd.postalCode}	${tender_data.data.procuringEntity.address.postalCode}
	Wait Element Visibility And Input Text	${locator_lotAdd.countryName}	${tender_data.data.procuringEntity.address.countryName}
	Wait Element Visibility And Input Text	${locator_lotAdd.region}	${tender_data.data.procuringEntity.address.region}
	Wait Element Visibility And Input Text	${locator_lotAdd.locality}	${tender_data.data.procuringEntity.address.locality}
	Wait Element Visibility And Input Text	${locator_lotAdd.streetAddress}	${tender_data.data.procuringEntity.address.streetAddress}

	#contactPoint
	Wait Element Visibility And Input Text	css=input[data-id='name']	${tender_data.data.procuringEntity.contactPoint.name}
	${modified_phone} = 	Remove String	${tender_data.data.procuringEntity.contactPoint.telephone}	${SPACE}
	${modified_phone} = 	Remove String	${modified_phone}	-
	${modified_phone} = 	Remove String	${modified_phone}	(
	${modified_phone} = 	Remove String	${modified_phone}	)
	${modified_phone} = 	Set Variable If	'+38' in '${modified_phone}'	${modified_phone}	+38067${modified_phone}
	${modified_phone} = 	Get Substring	${modified_phone}	0	13
	Wait Element Visibility And Input Text	css=input[data-id='telephone']	${modified_phone}
	Wait Element Visibility And Input Text	css=input[data-id='email']	${USERS.users['${username}'].email}
	Wait Visibility And Click Element	${locator_tenderAdd.btnSave}

#step 1
	Додати lots	${lots}

#step 2
	${count} = 	Get Length	${items}
	Run Keyword If	${count} > 0	Додати items	${items}
	Wait Visibility And Click Element	${locator_tenderAdd.btnSave}
	Wait Until Element Is Visible	css=section[data-id="step3"]	${COMMONWAIT}

#step 3
#	Click Element			css=#tab_2
#	${count} = 	Get Length	${features}
#	Run Keyword If	${count} > 0	Додати features	${features}
	Wait Visibility And Click Element	${locator_tenderAdd.btnSave}

#step 4
	Wait Until Element Is Visible	css=section[data-id="step4"]	${COMMONWAIT}
#	Додати документ при створенні закупівлі
#todo: implement method Додати документ при створенні закупівлі
	Wait Visibility And Click Element	${locator_tenderAdd.btnSave}

#step 5
	Wait Until Element Is Visible	css=section[data-id="step5"]	${COMMONWAIT}
	Wait Until Element Is Enabled	${locator_tenderCreation.buttonSend}	${COMMONWAIT}
	Wait Visibility And Click Element	${locator_tenderCreation.buttonSend}
#TODO проверка на текст. Необходимо проверить и заменить
	Close Confirmation In Editor	Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
	Switch To PMFrame
#	Wait Until Element Not Stale	${tender_data_title}	40
	Wait For Element With Reload	xpath=//div[@id='tenderStatus' and contains(., 'Період уточнень')]	1
	${tender_id} = 	Get Text	css=div#tenderId
	[Return]  ${tender_id}
#	[return]  ${tender_id}


Додати lots
	[Arguments]  ${lots}
	${lots_count} = 	Get Length	${lots}
	Switch To PMFrame

	: FOR    ${index}    IN RANGE    0    ${lots_count}
	\    Wait Element Visibility And Input Text	css=input[data-id='title']	${lots[${index}].title}
	\    Wait Element Visibility And Input Text	css=textarea[data-id='description']	${lots[${index}].description}
	\    ${value_amount} = 	privatmarket_service.convert_float_to_string	${lots[${index}].value.amount}
	\    ${minimalStep_amount} = 	Convert to String	${lots[${index}].minimalStep.amount}
	\    Wait Element Visibility And Input Text	css=input[data-id='valueAmount']	${value_amount}
	\    Sleep	3s
#	\    Input Text		css=input[data-id='minimalStepAmount']	${minimalStep_amount}1
	\    Wait Element Visibility And Input Text	css=input[data-id='minimalStepAmount']	${minimalStep_amount}
#	\    Sleep	1s
	\    Wait Visibility And Click Element	css=div.lot-guarantee label
	\    Wait Element Visibility And Input Text	css=input[data-id='guaranteeAmount']	1


Додати items
	[Arguments]  ${items}
	${items_count} = 	Get Length	${items}
	Switch To PMFrame
	: FOR    ${index}    IN RANGE    0    ${items_count}
#	todo: настроить тесты для нескольких предметов закупки по индексу
	\    Wait Element Visibility And Input Text	${locator_lotAdd.description}	${items[${index}].description}
	\    Wait Element Visibility And Input Text	${locator_lotAdd.quantity}	${items[${index}].quantity}
#	\todo Раскомитить строку. Временная замена, пока вернут текстовую меру для закупок
    \    ${unitName} =  get_unit_name  ${items[${index}].unit.name}
	\    Wait Visibility And Click Element	xpath=//select[@data-id='unit']/option[text()='${unitName}']
#	\    Wait Visibility And Click Element	xpath=//select[@data-id='unit']/option[@value='6']
	\    ${deliveryStartDate} =	Get Regexp Matches	${items[${index}].deliveryDate.startDate}	(\\d{4}-\\d{2}-\\d{2})
	\    ${deliveryStartDate} =	Convert Date	${deliveryStartDate[0]}	result_format=%d-%m-%Y
	\    ${deliveryEndDate} =	Get Regexp Matches	${items[${index}].deliveryDate.endDate}	(\\d{4}-\\d{2}-\\d{2})
	\    ${deliveryEndDate} =	Convert Date	${deliveryEndDate[0]}	result_format=%d-%m-%Y
	\    Wait Visibility And Click Element	${locator_lotAdd.adressType}
	\    Wait Element Visibility And Input Text	${locator_lotAdd.postalCode}	${items[${index}].deliveryAddress.postalCode}
	\    Wait Element Visibility And Input Text	${locator_lotAdd.countryName}	${items[${index}].deliveryAddress.countryName}
	\    Wait Element Visibility And Input Text	${locator_lotAdd.region}	${items[${index}].deliveryAddress.region}
	\    Wait Element Visibility And Input Text	${locator_lotAdd.locality}	${items[${index}].deliveryAddress.locality}
	\    Wait Element Visibility And Input Text	${locator_lotAdd.streetAddress}	${items[${index}].deliveryAddress.streetAddress}
	\    Wait Until Element Is Visible	${locator_lotAdd.deliveryEndDate}	${COMMONWAIT}
	\    Set Date In Item	${index}	deliveryDate	startDate	${items[${index}].deliveryDate.startDate}
	\    Set Date In Item	${index}	deliveryDate	endDate	${items[${index}].deliveryDate.endDate}


Завантажити документ
	[Arguments]  ${user_name}  ${filepath}  ${tenderId}
#	перейдем к редактированию
	Wait For Element With Reload	${locator_tenderClaim.buttonCreate}	1
	Wait Visibility And Click Element	${locator_tenderClaim.buttonCreate}
#	откроем нужную вкладку
	Wait Visibility And Click Element	${locator_tenderAdd.thirdTab}
#	загрузим файл
	Wait Visibility And Click Element	${locator_tenderAdd.docs.yes}
	Wait Visibility And Click Element	${locator_tenderAdd.docs.loader}

	Wait Visibility And Click Element	${locator_tenderAdd.docs.fileTitle}
	Choose File	id=afpFile	${filePath}
	Sleep	5s
	Wait Visibility And Click Element	xpath=//a[contains(@ng-class, 'file.currFileVfvError')]
	Wait Visibility And Click Element	xpath=//li[contains(@ng-click, 'setFileType')][1]
#	todo временный шаг, пока не добавят автоскрытие дропбокса
	Wait Visibility And Click Element	xpath=//a[contains(@ng-class, 'file.currFileVfvError')]
	Wait Visibility And Click Element	xpath=//button[contains(@ng-click, 'addFileFunction')]
	Wait Visibility And Click Element	${locator_tenderAdd.btnSave}
	Wait Until Element Is Visible	css=section[data-id="step5"]	${COMMONWAIT}
	Wait Visibility And Click Element	${locator_tenderCreation.buttonSend}
#Дождемся подтверждения и обновим страницу, поскольку тут не выходит его закрыть
	Wait Until Element Is Visible		css=div.modal-body.info-div	${COMMONWAIT}
#TODO проверка на текст. Необходимо проверить и заменить. PopUp
	Close Confirmation In Editor	Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
	Sleep  180s
#	Wait Until Element Contains			css=div.modal-body.info-div	Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.	${COMMONWAIT}
#	Reload Page


Відкрити детальну інформацию по позиціям
	#check if extra information is already opened
	${element_class} =	Get Element Attribute	xpath=//li[contains(@ng-class, 'description')]@class
	Run Keyword IF	'checked-nav' in '${element_class}'	Return From Keyword	True

	Wait Visibility And Click Element	${locator_tenderInfo.lotDescriptionBtn}
	Wait Until Element Is Visible	${locator_tenderInfo.lotDescriptionBody}	${COMMONWAIT}
	Wait Visibility And Click Element	${tender_data_items.description}
	Wait Until Element Is Visible	css=div[ng-if='adb.classification']	${COMMONWAIT}


Обрати потрібний лот за id
	[Arguments]  ${lot_id}
	Wait For Element With Reload	css=div.lot-chooser	1
	Wait Until Element Is Visible		css=div.lot-chooser	timeout=${COMMONWAIT}
	Wait Visibility And Click Element	css=div.lot-chooser
	Wait Visibility And Click Element	xpath=//div[@ng-repeat='lot in model.lotPortion' and contains(., '${lot_id}')]


Отримати інформацію із предмету
	[Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
	Run Keyword And Return If	'${field_name}' == 'classification.scheme'			Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'classification.id'				Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'classification.description'	Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'unit.code'	Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'additionalClassification[0].scheme'			Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'additionalClassification[0].id'				Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'additionalClassifications[0].description'	Отримати текст елемента ${field_name}	${field_name}
	Run Keyword And Return If	'${field_name}' == 'quantity'	Отримати строку quantity	${field_name}
    ${element} =  Set Variable  xpath=//section/div[contains(., '${object_id}') and contains(@class, 'lot-info')]${tender_data_item.${field_name}}
	Wait Until Element Is Visible  ${element}  timeout=${COMMONWAIT}
	${result_full} =  Get Text	${element}
	${result} =  Strip String	${result_full}
	[Return]  ${result}


Отримати інформацію із запитання
	[Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
	${element} =  Set Variable  xpath=//div[contains(@class, 'faq') and contains(., '${question_id}')]${tender_data_question.${field_name}}
	Wait For Element With Reload  ${element}  2
	${result_full} =  Get Text	${element}
	${result} =  Strip String	${result_full}
	[Return]  ${result}


Отримати інформацію із пропозиції
	[Arguments]  ${username}  ${tender_uaid}  ${field}
	${bid}=  privatmarket.Отримати пропозицію  ${username}  ${tender_uaid}
	[Return]  ${bid.data.${field}}


Отримати інформацію із лоту
	[Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
	${className} =  Get Element Attribute  xpath=//section[@id='lotSection']/section[contains(., '${object_id}')]//li[1]@class
	Run Keyword If  '${className}' == 'simple-nav_item active'  Wait Visibility And Click Element  //section[@id='lotSection']/section[contains(., '${object_id}')]//li[1]/a

	${element} =  Set Variable  xpath=//section[@id='lotSection']/section[contains(., '${object_id}')]${tender_data_lot.${field_name}}

	Run Keyword And Return If	'${element}' == 'minimalStep.amount'					Отримати суму	${element}	${item}

	${result_full} =  Get Text	${element}
	${result} =  Strip String	${result_full}
	[Return]  ${result}


Отримати інформацію із документа
	[Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
	Wait For Element With Reload  ${tender_data_documentation.${field}}  1
	Wait Until Element Is Visible  ${tender_data_documentation.${field}}	${COMMONWAIT}
	${result}=  get text  ${tender_data_documentation.${field}}
	[Return]  ${result}


Отримати документ
	[Arguments]  ${username}  ${tender_uaid}  ${doc_id}
	Wait For Element With Reload  ${tender_data_documentation.title}  1
    Wait Visibility And Click Element  ${tender_data_documentation.title}
    # Добален слип, т.к. док не успевал загрузиться
    sleep  20s
    ${file_name_full} =  Get Text  ${tender_data_documentation.title}
    ${file_name} =  Strip String  ${file_name_full}
    [Return]  ${file_name}


Задати запитання на тендер
	[Arguments]  ${username}  ${tender_uaid}  ${question}
	Switch To PMFrame
	Wait Visibility And Click Element	${locator_question.create}
	sleep	4s
	Wait Until Element Is Visible	${locator_question.title}	${COMMONWAIT}
	Wait Until Element Is Enabled	${locator_question.title}	${COMMONWAIT}
	Input text	${locator_question.title}				${question.data.title}
	Wait Element Visibility And Input Text	${locator_question.description}	${question.data.description}
	Wait Element Visibility And Input Text	${locator_question.usersEmail}	${USERS.users['${provider}'].email}
	Select From List By Value	${locator_question.country}	UA
	Wait Element Visibility And Input Text	${locator_question.postalCode}	${question.data.author.address.postalCode}
	Wait Element Visibility And Input Text	${locator_question.region}	${question.data.author.address.region}
	Wait Element Visibility And Input Text	${locator_question.locality}	${question.data.author.address.locality}
	Wait Element Visibility And Input Text	${locator_question.street}	${question.data.author.address.streetAddress}
	Wait Visibility And Click Element	${locator_question.sendQuestion}
	Wait For Notification	Ваше запитання успішно включено до черги на відправку. Дякуємо за звернення!
	Wait Visibility And Click Element	${locator_question.hideModal}
	Wait Until Element Is Not Visible	${locator_question.title}	${COMMONWAIT}


Отримати інформацію із тендера
	[Arguments]  ${user_name}  ${tender_uaid}  ${field_name}
	Switch To PMFrame
	Wait Until Element Is Visible		${tender_data_title}	${COMMONWAIT}

	#check tender type
	${item} =	Run Keyword If	'multiItem' in '${SUITE_NAME}'	Отримати номер позиції	${tender_uaid}	items\\[(\\d)\\]
		...  ELSE	Convert To Integer	0

	${lot} =	Run Keyword If	'multiLot' in '${SUITE_NAME}'	Отримати номер позиції	${tender_uaid}	lots\\[(\\d)\\]
	...  ELSE	Set Variable	None

	#switch to correct tab
	${tab_num} =	Set Variable If
		...  'questions' in '${tender_uaid}'	2
		...  'complaints' in '${tender_uaid}'	3
		...  1
	Switch To Tab	${tab_num}

	#show extra information if it need
	Run Keyword If	${tab_num} == 1	Run Keywords	Відкрити детальну інформацию по позиціям

	#get information
	${result} =	Отримати інформацію зі сторінки	${item}	${tender_uaid}	${field_name}
	[Return]  ${result}


Convert Amount To Number
	[Arguments]  ${field_name}
	${result_full} =	Get Text	${tender_data_${field_name}}
	${text} =	Strip String	${result_full}
	${text_new}=  Replace String	${text}	${SPACE}	${EMPTY}
	${result}=	convert to number	${text_new}
	[Return]	${result}


Отримати інформацію зі сторінки
	[Arguments]  ${item}  ${base_tender_uaid}  ${field_name}
	${element} = 	Replace String	${field_name}	items[${item}]	items
	${element} = 	Replace String	${element}	lots[${item}]	lots

	Run Keyword And Return If	'${element}' == 'enquiryPeriod.startDate'		Отримати дату та час	${element}	1	${item}
	Run Keyword And Return If	'${element}' == 'enquiryPeriod.endDate'			Отримати дату та час	${element}	1	${item}
	Run Keyword And Return If	'${element}' == 'tenderPeriod.startDate'		Отримати дату та час	${element}	1	${item}
	Run Keyword And Return If	'${element}' == 'tenderPeriod.endDate'			Отримати дату та час	${element}	1	${item}
	Run Keyword And Return If	'${element}' == 'questions[0].date'				Отримати дату та час	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'bids'							Перевірити присутність bids
	Run Keyword And Return If	'${element}' == 'value.amount'	Convert Amount To Number	${element}
	Run Keyword And Return If	'${element}' == 'value.currency'			Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'value.valueAddedTaxIncluded'				Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'status'						Отримати інформацію з ${element}	${element}
	Run Keyword And Return If	'${element}' == 'documents[0].title'			Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'causeDescription'				Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'title_en'						Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'title_ru'						Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'title_ua'						Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'description_en'				Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'description_ru'				Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'description_ua'				Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.classification.scheme'						Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.classification.id'							Отримати строку		${element}	3	${item}
	Run Keyword And Return If	'${element}' == 'items.description'									Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.quantity'									Отримати суму	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.classification.description'					Отримати класифікацію	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.additionalClassifications[0].scheme'			Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items.additionalClassifications[0].id'				Отримати строку	${element}	3	${item}
	Run Keyword And Return If	'${element}' == 'items.additionalClassifications[0].description'	Отримати класифікацію	${element}	${item}
	Run Keyword And Return If	'items.deliveryAddres' in '${element}'								Отримати текст елемента	${element}	${item}

	Run Keyword And Return If	'${element}' == 'items[0].classification.scheme'			Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items[0].classification.id'				Отримати текст елемента	${element}	${item}
	Run Keyword And Return If	'${element}' == 'items[0].classification.description'	Отримати текст елемента	${element}	${item}

	Run Keyword And Return If	'${element}' == 'items.deliveryDate.startDate'			Отримати дату та час	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'items.deliveryDate.endDate'			Отримати дату та час	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'items.unit.name'						Отримати назву	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'items.unit.code'						Отримати код	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'minimalStep.amount'					Convert Amount To Number	${element}
	Run Keyword And Return If	'${element}' == 'items.deliveryLocation.latitude'		Отримати число	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'items.deliveryLocation.longitude'		Отримати число	${element}	0	${item}
	Run Keyword And Return If	'${element}' == 'auctionPeriod.startDate'				Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'procurementMethodType'					Отримати інформацію з ${element}	${element}
	Run Keyword And Return If	'${element}' == 'lots.value.amount'	Convert Amount To Number	${element}
	Run Keyword And Return If	'${element}' == 'lots.value.currency'	Отримати інформацію з валюти	${element}	${item}
	Run Keyword And Return If	'${element}' == 'lots.value.valueAddedTaxIncluded'	Отримати інформацію з типу податку	${element}	${item}

	Run Keyword And Return If	'${element}' == 'minimalStep.amount'	Convert Amount To Number	${element}
	Run Keyword And Return If	'${element}' == 'minimalStep.currency'	Отримати інформацію з валюти	${element}	${item}
	Run Keyword And Return If	'${element}' == 'minimalStep.valueAddedTaxIncluded'	Отримати інформацію з типу податку	${element}	${item}

	Run Keyword And Return If	'${element}' == 'lots.minimalStep.amount'	Convert Amount To Number	${element}
	Run Keyword And Return If	'${element}' == 'lots.minimalStep.currency'	Отримати інформацію з валюти	${element}	${item}
	Run Keyword And Return If	'${element}' == 'lots.minimalStep.valueAddedTaxIncluded'	Отримати інформацію з типу податку	${element}	${item}

	Run Keyword If	'${element}' == 'questions[0].title'		Wait For Element With Reload	${tender_data_${element}}	2
	Run Keyword If	'${element}' == 'questions[0].answer'		Wait For Element With Reload	${tender_data_${element}}	2

	Run Keyword And Return If	'${element}' == 'cancellations[0].status'					Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'cancellations[0].documents[0].title'		Отримати інформацію з ${element}	${element}	${item}
	Run Keyword And Return If	'${element}' == 'procuringEntity.identifier.scheme'			Отримати інформацію з ${element}	${element}	${item}

	Wait Until Element Is Visible	${tender_data_${element}}	${COMMONWAIT}
	${result_full} =	Get Text	${tender_data_${element}}
	${result} =	Strip String	${result_full}
	[Return]	${result}


Отримати текст елемента
	[Arguments]  ${element_name}  ${item}
	Wait Until Element Is Visible	${tender_data_${element_name}}
	@{itemsList}=					Get Webelements	${tender_data_${element_name}}
	${num} =						Set Variable	${item}
	${result_full} =				Get Text		${itemsList[${num}]}
	[Return]  ${result_full}

Отримати текст елемента classification.scheme
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result_full} =	Get Text	${tender_data_lots.${element}}
	${result} =  get_classification_type  ${result_full}
	[Return]  ${result}

Отримати текст елемента additionalClassification[0].scheme
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result_full} =	Get Text	${tender_data_lots.${element}}
	${result} =  get_classification_type  ${result_full}
	[Return]  ${result}

Отримати текст елемента classification.id
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result} =	Get Text	${tender_data_lots.${element}}
#	${result} =  get_classification_type  ${result_full}
	[Return]  ${result}

Отримати текст елемента additionalClassification[0].id
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result} =	Get Text	${tender_data_lots.${element}}
#	${result} =  get_classification_type  ${result_full}
	[Return]  ${result}

Отримати текст елемента classification.description
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result_full} =	Get Text	${tender_data_lots.${element}}
	${result} =  strip string  ${result_full}
	[Return]  ${result}

Отримати текст елемента additionalClassifications[0].description
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result_full} =	Get Text	${tender_data_lots.${element}}
	${result} =  strip string  ${result_full}
	[Return]  ${result}

Отримати текст елемента unit.code
	[Arguments]  ${element}
	Wait Until Element Is Visible	${tender_data_lots.${element}}
	${result_full} =	Get Text	${tender_data_lots.${element}}
	${result} =  get_unit_code  ${result_full}
	[Return]  ${result}

Отримати строку
	[Arguments]  ${element_name}  ${position_number}  ${item}
	${result_full} =				Отримати текст елемента	${element_name}	${item}
	${result} =						Strip String	${result_full}
	${result} =						Replace String	${result}	,	${EMPTY}
	${values_list} =				Split String	${result}
	${result} =						Strip String	${values_list[${position_number}]}	mode=both	characters=:
	[Return]  ${result}

Отримати строку quantity
	[Arguments]  ${element_name}
	${result_full} =	Get Text	${element_name}
	${result} =	Strip String	${result_full}
	${result} =	Replace String	${result}	.00	${EMPTY}
	${result} =	Strip String	${result}
	[Return]  ${result}

Отримати число
	[Arguments]  ${element_name}  ${position_number}  ${item}
	${value}=	Отримати строку		${element_name}	${position_number}	${item}
	${result}=	Convert To Number	${value}
	[Return]	${result}


Отримати суму
	[Arguments]  ${element_name}  ${item}
	${result}=	Отримати текст елемента	${element_name}	${item}
	${result}=	Remove String	${result}	${SPACE}
	${result} =	Replace String	${result}	,	.
	${result}=	Convert To Number	${result}
	[Return]	${result}


Отримати ціле число
	[Arguments]  ${element_name}  ${position_number}  ${item}
	${value}=	Отримати строку		${element_name}	${position_number}	${item}
	${result}=	Convert To Integer	${value}
	[Return]	${result}


Отримати дату та час
	[Arguments]  ${element_name}  ${shift}  ${item}
	${result_full} =	Отримати текст елемента	${element_name}	${item}
	${work_string} =	Replace String		${result_full}	${SPACE},${SPACE}	${SPACE}
	${work_string} =	Replace String		${result_full}	,${SPACE}	${SPACE}
	${values_list} =	Split String		${work_string}
	${day} =			Convert To String	${values_list[0 + ${shift}]}
	${month} =			get_month_number	${values_list[1 + ${shift}]}
	${month} =  Set Variable If  ${month} < 10  0${month}
	${year} =			Convert To String	${values_list[2 + ${shift}]}
	${time} =			Convert To String	${values_list[3 + ${shift}]}
	${date}=			Convert To String	${year}-${month}-${day} ${time}
	${result}=  get_time_with_offset  ${date}
	[Return]	${result}


Отримати класифікацію
	[Arguments]  ${element_name}  ${item}
	${result_full} =	Отримати текст елемента	${element_name}	${item}
	${reg_expresion} =	Set Variable	[0-9A-zА-Яа-яёЁЇїІіЄєҐґ\\s\\:]+\: \\w+[\\d\\.\\-]+ ([А-Яа-яёЁЇїІіЄєҐґ\\s;,\\"_\\(\\)\\.]+)
	${result} =			Get Regexp Matches	${result_full}	${reg_expresion}	1
	[Return]	${result[0]}


Отримати назву
	[Arguments]  ${element_name}  ${position_number}  ${item}
	${result_full} =	Отримати строку	${element_name}	${position_number}	${item}
	${result} =			get_unit_name	${result_full}
	[Return]	${result}


Отримати код
	[Arguments]  ${element_name}  ${position_number}  ${item}
	${result_full} =	Отримати строку	${element_name}	${position_number}	${item}
	${unit_name} = 		get_unit_name	${result_full}
	${result} =			get_unit_code	${unit_name}
	[Return]	${result}


Отримати номер позиції
	[Arguments]  ${element_name}  ${reg_exp}
	${item} =	Get Regexp Matches	${element_name}	${reg_exp}	1
	${length} =	Get Length	${item}
	${result} =	Run Keyword If	'${length}' == '0'	Set Variable	0
		...  ELSE	Convert To Integer	${item[0]}
	[Return]  ${result}


Перевірити присутність bids
	Element Should Not Be Visible	${tender_data_${element}}
	[Return]	${None}


Отримати інформацію з auctionPeriod.startDate
	[Arguments]  ${element}  ${item}
	Wait For Element With Reload	${tender_data_${element}}	1
	${start_date} =					Отримати дату та час	${element}	1	${item}
	${result} =	get_time_with_offset	${start_date}
	[Return]  ${result}


Отримати інформацію з value.currency
	[Arguments]    ${element_name}  ${item}
	${currency} =	Отримати строку	${element_name}	0	${item}
	${currency_type} =	get_currency_type	${currency}
	[Return]  ${currency_type}


Отримати інформацію з lots.value.currency
	[Arguments]    ${element_name}  ${item}
	${currency} =	Отримати строку	${element_name}	0	${item}
	${currency_type} =	get_currency_type	${currency}
	[Return]  ${currency_type}

Отримати інформацію з валюти
	[Arguments]    ${element_name}  ${item}
	${currency} =	Отримати строку	${element_name}	0	${item}
	${currency_type} =	get_currency_type	${currency}
	[Return]  ${currency_type}

Отримати інформацію з value.valueAddedTaxIncluded
	[Arguments]  ${element_name}  ${item}
	${value_added_tax_included} =	Get text	${tender_data_${element_name}}
	${result} =	Set Variable If	'з ПДВ' in '${value_added_tax_included}'	True
	${result} =	Convert To Boolean	${result}
	[Return]  ${result}

Отримати інформацію з lots.value.valueAddedTaxIncluded
	[Arguments]  ${element_name}  ${item}
	${value_added_tax_included} =	Get text	${tender_data_${element_name}}
	${result} =	Set Variable If	'з ПДВ' in '${value_added_tax_included}'	True
	${result} =	Convert To Boolean	${result}
	[Return]  ${result}

Отримати інформацію з типу податку
	[Arguments]  ${element_name}  ${item}
	${value_added_tax_included} =	Get text	${tender_data_${element_name}}
	${result} =	Set Variable If	'з ПДВ' in '${value_added_tax_included}'	True
	${result} =	Convert To Boolean	${result}
	[Return]  ${result}


Отримати інформацію з items.additionalClassifications[0].scheme
	[Arguments]  ${element}  ${item}
	${first_part} =		Отримати строку	${element}	1	${item}
	${second_part} =	Отримати строку	${element}	2	${item}
	${result} =			Set Variable	${first_part} ${second_part}
	${currency_type} =	get_classification_type	${result}
	[Return]  ${currency_type}


Отримати інформацію з items.classification.scheme
	[Arguments]  ${element}  ${item}
	${first_part} =		Отримати строку	${element}	1	${item}
	${second_part} =	Отримати строку	${element}	2	${item}
	${result} =			Set Variable	${first_part} ${second_part}
	${currency_type} =	get_classification_type	${result}
	[Return]  ${currency_type}


Отримати інформацію з procurementMethodType
	[Arguments]  ${element_name}
	${method_name} =	Get text	${tender_data_${element_name}}
	${method_type} =	get_procurement_method_type	${method_name}
	[Return]  ${method_type}


Отримати інформацію з status
	[Arguments]  ${element_name}
	privatmarket.Оновити сторінку з тендером
	Wait Until Element Is Visible	${tender_data_${element_name}}	${COMMONWAIT}
	#Added sleep, becource we taketext in status bar
	Sleep  5s
	${status_name} =	Get text	${tender_data_${element_name}}
	${status_type} =	get_status_type	${status_name}
	[Return]  ${status_type}


Отримати інформацію з cancellations[0].status
	[Arguments]  ${element}  ${item}
	${text} =	Отримати текст елемента  ${element}  ${item}
	${result} =	Set Variable If	'Отменено' in '${text}'	active
	${result} =	Set Variable If	'Відмінено' in '${text}'	active
	[Return]  ${result}


Отримати інформацію з cancellations[0].documents[0].title
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Replace String	${text}	\\	\\\\
	[Return]	${newText}

Отримати інформацію з documents[0].title
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Replace String		${text}	\\	\\\\
	[Return]	${newText}

Отримати інформацію з items.additionalClassifications.[0].description
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Replace String Using Regexp		${text}	.*\\d	${EMPTY}
	${result} =		Strip String	${newText}
	[Return]	${result}

Отримати інформацію з items.additionalClassifications.[0].id
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Get Regexp Matches		${text}	: (\\d.*\\d)	1
	${result} = 	Convert To String  ${newText[0]}
	[Return]	${result}

Отримати інформацію з items.additionalClassifications.[0].scheme
	[Arguments]  ${element}  ${item}
	${text} =			Отримати текст елемента  ${element}  ${item}
	${newText} =		Get Regexp Matches		${text}	Классификатор (.*):	1
	${convertText} = 	Convert To String  ${newText[0]}
	${result} =			get_classification_type	${convertText}
	[Return]	${result}

Отримати інформацію з causeDescription
	[Arguments]  ${element}  ${item}
	Wait Enable And Click Element		css=#tenderType>span
	${text} =	Отримати текст елемента  ${element}  ${item}
	[Return]	${text}

Отримати інформацію з procuringEntity.identifier.scheme
	[Arguments]  ${element}  ${item}
	${text} =		Отримати текст елемента  ${element}  ${item}
	${newText} =	Replace String		${text}	:	${EMPTY}
	${result} =		get_identification_scheme	${newText}
	[Return]	${result}


Внести зміни в тендер
	[Arguments]  ${user_name}  ${tenderId}	${parameter}	${value}
	Wait For Element With Reload	${locator_tenderClaim.buttonCreate}	1
	Switch To PMFrame
	Wait Visibility And Click Element	${locator_tenderClaim.buttonCreate}
	Switch To PMFrame
#	Wait Visibility And Click Element	css=#tab_0 a
	Wait Element Visibility And Input Text	css=textarea[data-id='procurementDescription']	${value}

	Wait Visibility And Click Element	${locator_tenderAdd.btnSave}
	Wait Until Element Is Visible	css=section[data-id="step2"]	${COMMONWAIT}
	Wait Visibility And Click Element	css=#tab_4 a
	Wait Visibility And Click Element	${locator_tenderCreation.buttonSend}
	#Дождемся подтверждения и обновим страницу, поскольку тут не выходит его закрыть
	Wait Until Element Is Visible	css=div.modal-body.info-div	${COMMONWAIT}
	Wait Until Element Contains	css=div.modal-body.info-div	Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.	${COMMONWAIT}
	Reload Page


Створити вимогу
	[Arguments]  ${user}  ${tender_id}  ${complaints}
	privatmarket.Пошук тендера по ідентифікатору	${user}	${tenderId}
	Switch To Tab						3
	Wait Enable And Click Element		xpath=//button[contains(@ng-click, 'act.setComplaintOnlyTender()')]
	Wait For Ajax
	Wait For Element Value				css=input[ng-model='model.person.phone']
#	Wait Until Element Is Visible		xpath=//input[@ng-model='model.complaint.user.title']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//input[@ng-model='model.complaint.user.title']	timeout=${COMMONWAIT}
	Wait Element Visibility And Input Text	xpath=//input[@ng-model='model.complaint.user.title']	${complaints.data.title}
	Wait Element Visibility And Input Text	css=div.info-item-val textarea	${complaints.data.description}
	Wait Until Element Is Visible		xpath=//input[@ng-model='model.person.email']	timeout=${COMMONWAIT}
	Scroll Page To Element				xpath=//input[@ng-model='model.person.email']
	Input Text							xpath=//input[@ng-model='model.person.email']			${USERS.users['${user}'].email}
	Wait Visibility And Click Element	css=button[ng-click='act.saveComplaint()']
	Wait For Ajax
	Wait Until Element Is Enabled		css=div.alert-info	${COMMONWAIT}
	Wait Until Element Contains			css=div.alert-info	Ваше требование успешно сохранено!	${COMMONWAIT}
	${claim_data} =	Create Dictionary	id=123
	${claim_resp} =	Create Dictionary	data=${claim_data}
	[Return]  ${claim_resp}


Завантажити документацію до вимоги
	[Arguments]  ${user}  ${tender_id}  ${complaints}  ${document}
	${correctFilePath} = 				Replace String	${document}	\\	\/
	Execute Javascript					$("#fileToUpload").removeClass();
	Choose File							css=input#fileToUpload	${correctFilePath}
	sleep								5s
	Wait Until Element Is Visible		css=div.file-item
	[Return]  ${document}


Подати вимогу
	[Arguments]  ${user}  ${tender_id}  ${complaints}  ${confrimation_data}
	Wait Visibility And Click Element	xpath=//button[@ng-click='act.sendComplaint()']
	Wait For Ajax
	Wait Until Element Is Enabled		css=div.alert-info	${COMMONWAIT}
	Wait Until Element Contains			css=div.alert-info	Ваше требование успешно отправлено!	${COMMONWAIT}
	sleep								3s
	Wait Until Element Is Not Visible	xpath=//input[@ng-model="model.question.title"]	timeout=${COMMONWAIT}
	Wait Visibility And Click Element	css=span[ng-click='act.hideModal()']
#	Click Element						css=span[ng-click='act.hideModal()']
	sleep								3s
	Wait Until Element Is Not Visible	css=div.info-item-val textarea	${COMMONWAIT}
	Element Should Not Be Visible		css=div.error


Скасувати вимогу
	[Arguments]    ${user}  ${tender_id}  ${claim_data}  ${cancellation_data}
#	Wait Until Element Is Visible		css=a[ng-click='act.showCancelComplaintWnd(q)']	timeout=${COMMONWAIT}
#	Wait Until Element Is Enabled		css=a[ng-click='act.showCancelComplaintWnd(q)']	timeout=${COMMONWAIT}
#	Click element						css=a[ng-click='act.showCancelComplaintWnd(q)']
	Wait Visibility And Click Element	css=a[ng-click='act.showCancelComplaintWnd(q)']

	Wait Until Element Is Visible		xpath=//textarea[@ng-model='model.cancelComplaint.reason']	timeout=${COMMONWAIT}
	Wait Until Element Is Enabled		xpath=//textarea[@ng-model='model.cancelComplaint.reason']	timeout=${COMMONWAIT}
	Input Text							xpath=//textarea[@ng-model='model.cancelComplaint.reason']	${cancellation_data.data.cancellationReason}
	Wait Visibility And Click Element	css=button[ng-click='act.cancelComplaint()']
	Wait For Ajax
	Wait Until Element Is Not Visible	css=button[ng-click='act.cancelComplaint()']	timeout=${COMMONWAIT}
	Wait Until Element Contains			css=span#cmplStatus0	Отменено	timeout=${COMMONWAIT}


Задати питання
	[Arguments]  ${provider}  ${tender_id}  ${question}
	privatmarket.Оновити сторінку з тендером
	Switch To Tab	2
	Wait For Ajax
#	Wait Until Element Not Stale	xpath=//button[@ng-click='act.sendEnquiry()']	${COMMONWAIT}
	Wait Until Element Is Enabled	xpath=//button[@ng-click='act.sendEnquiry()']	${COMMONWAIT}
	Click Button	xpath=//button[@ng-click='act.sendEnquiry()']
	Заповнити форму питання	${provider}	${tender_id}	${question}
	Sleep	30s
	[Return]  True


Заповнити форму питання
	[Arguments]  ${provider}  ${tender_id}  ${question}
	Wait For Ajax
	sleep	4s
#	Wait For Element Value	css=input[ng-model='model.person.phone']
	Wait Until Element Is Visible	xpath=//input[@ng-model="model.question.title"]				timeout=10
	Wait Until Element Is Enabled	xpath=//input[@ng-model="model.question.title"]				timeout=10
	Input text	xpath=//input[@ng-model="model.question.title"]				${question.data.title}
	Wait Element Visibility And Input Text	xpath=//textarea[@ng-model='model.question.description']	${question.data.description}
	Wait Element Visibility And Input Text	xpath=//input[@ng-model='model.person.email']	${USERS.users['${provider}'].email}
	Select From List By Value	id=addressCountry	UA
	Wait Element Visibility And Input Text	id=addressPostalCode	${question.data.author.address.postalCode}
	Wait Element Visibility And Input Text	id=addressRegion	${question.data.author.address.region}
	Wait Element Visibility And Input Text	id=addressLocality	${question.data.author.address.locality}
	Wait Element Visibility And Input Text	id=addressStreet	${question.data.author.address.streetAddress}
	Wait Visibility And Click Element	xpath=//button[@ng-click='act.sendQuestion()']
	Wait For Notification	Ваше запитання успішно включено до черги на відправку. Дякуємо за звернення!
	Wait Visibility And Click Element	css=span[ng-click='act.hideModal()']
	Wait Until Element Is Not Visible	xpath=//input[@ng-model='model.question.title']	timeout=20


Задати питання до лоту
	[Arguments]  ${provider}  ${tender_id}  ${lot_id}  ${question}
	Обрати потрібний лот за id	${lot_id}
	Wait Enable And Click Element	css=a[ng-click='act.sendLotEnquiry()']
	Заповнити форму питання			${question.data.title}	${question.data.description}	${USERS.users['${provider}'].email}
	[Return]  True


Відповісти на запитання
	[Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
	Switch To PMFrame
	Switch To Tab	2
	Wait For Element With Reload	xpath=//button[contains(@ng-click, 'act.answerFaq')]	2
	Wait Visibility And Click Element	xpath=//button[contains(@ng-click, 'act.answerFaq')]
	Wait Element Visibility And Input Text	id=questionAnswer	${answer_data.data.answer}
	Sleep	2s
	Wait Visibility And Click Element	id=btnSendAnswer
	Wait For Notification	Ваша відповідь успішно відправлена!
	Wait Visibility And Click Element	css=span[ng-click='act.hideModal()']
	Wait Until Element Is Not Visible	id=questionAnswer	timeout=20
#этот слип нужен, т.к. нет синхронизации и квинта ищет ответ в следующем тесте... а его нет пока не синхранизируемся
	Sleep	90s


Оновити сторінку з тендером
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId
	Reload Page
	Switch To PMFrame


Подати цінову пропозицію
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId
	...	${ARGUMENTS[2]} ==  bid
	privatmarket.Оновити сторінку з тендером

	Run Keyword If	'без прив’язки до лоту' in '${TEST_NAME}'	Fail  Така ситуація не може виникнути
	Run Keyword If	'без нецінового показника' in '${TEST_NAME}'	Fail  Така ситуація не може виникнути

	Відкрити заявку
	${amount} =	Set Variable If
		...  'multiLotTender' in '${SUITE_NAME}'	${Arguments[2].data.lotValues[1]['value']['amount']}
		...  ${Arguments[2].data.value.amount}
	${amount} = 	Convert To String	${amount}

	Run Keyword If	'multiLotTender' in '${SUITE_NAME}'	Input Text	${locator_tenderClaim.checkedLot.fieldPrice}	${amount}
		...  ELSE	Input Text	${locator_tenderClaim.fieldPrice}	${amount}

	#go through 3 steps
	Wait Visibility And Click Element	${locator_tender.bid.BtnNext}
	Click If Visible	${locator_tender.complaint.btnSave}
	Wait Until Element Contains	css=div.step-info-title	2/3	${COMMONWAIT}
	Wait Visibility And Click Element	${locator_tender.bid.BtnNext}
	Click If Visible	${locator_tender.complaint.btnSave}
	Wait Until Element Contains	css=div.step-info-title	3/3	${COMMONWAIT}
	Fill Adress	${ARGUMENTS[2]}
	Fill Phone	${ARGUMENTS[2]}
	Switch To PMFrame
	Wait Enable And Click Element	${locator_tenderClaim.buttonSend}
	Close Confirmation	Ваша заявка була успішно включена до черги на відправку!
	privatmarket.Оновити сторінку з тендером
	[Return]	${Arguments[2]}


Fill Adress
	[Arguments]  ${bid}
	Switch To PMFrame
	Wait Visibility And Click Element	xpath=//a[contains(@ng-click, 'address')]
	Wait Element Visibility And Input Text	id=addressPostalCode	${bid.data.tenderers[0].address.postalCode}
	Wait Element Visibility And Input Text	id=addressRegion	${bid.data.tenderers[0].address.region}
	Wait Element Visibility And Input Text	id=addressLocality	${bid.data.tenderers[0].address.locality}
	Wait Element Visibility And Input Text	id=addressStreet	${bid.data.tenderers[0].address.streetAddress}
	Wait Visibility And Click Element	${locator_tender.complaint.btnSave}
#	wait until element is not visible	id=addressPostalCode


Fill Phone
	[Arguments]  ${bid}
	switch to pmframe
	Wait Visibility And Click Element	xpath=//a[contains(@ng-click, 'person')]
	Wait Element Visibility And Input Text	id=personPhone	${bid.data.tenderers[0].contactPoint.telephone}
	Wait Visibility And Click Element	${locator_tender.complaint.btnSave}
#	wait until element is not visible	id=addressPostalCode

Дочекатися статусу заявки
	[Arguments]  ${status}
	Wait Until Element Is Visible		xpath=//table[@class='bids']//tr[1]/td[4]
	Wait Until Keyword Succeeds			1min	10s	Element Should contain	xpath=//table[@class='bids']//tr[1]/td[4]	${status}


Відкрити заявку
	Wait For Ajax
	Switch To PMFrame
	Wait Until Element Is Visible	${tender_data_status}	${COMMONWAIT}

	${tender_status} =	Get text	${tender_data_status}
	Run Keyword Unless	'до початку періоду подачі' in '${TEST_NAME}'	Run Keyword If	'${tender_status}' == 'Період уточнень завершено'	Wait For Element With Reload	${locator_tenderClaim.buttonCreate}	1

#	Wait Until Element Not Stale		${locator_tenderClaim.buttonCreate}	30
	Wait Enable And Click Element		${locator_tenderClaim.buttonCreate}	${COMMONWAIT}
#	Wait For Ajax
	Wait Until Element Is Not Visible	${locator_tenderClaim.buttonCreate}	${COMMONWAIT}
	Switch To PMFrame
	Wait Until Element Contains	css=div.step-info-title	1/3	${COMMONWAIT}
	Switch To PMFrame


Змінити цінову пропозицію
	[Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
	Відкрити заявку
	Run Keyword 						Змінити ${fieldname}	${fieldvalue}
	Switch To PMFrame
	Wait Enable And Click Element	${locator_tenderClaim.buttonSend}
#TODO проверка на текст. Необходимо проверить и заменить
#    log to console  TODO проверка на текст. Необходимо проверить и заменить
#    debug
	Close Confirmation	Ваша заявка була успішно збережена!
	[Return]	${TRUE}


Змінити parameters.0.value
	[Arguments]  ${fieldvalue}
	Select From List	xpath=(//select[@ng-model='feature.userValue'])[1]	${fieldvalue}


Змінити lotValues.0.value.amount
	[Arguments]  ${fieldvalue}
	Wait Element Visibility And Input Text	${locator_tenderClaim.checkedLot.fieldPrice}	${fieldvalue}


Змінити value.amount
	[Arguments]  ${fieldvalue}
	#get correct step
	Wait Visibility And Click Element	${locator_tender.bid.BtnNext}
	Click If Visible	${locator_tender.complaint.btnSave}
	#input value
	Wait Until Element Contains	css=div.step-info-title	2/3	${COMMONWAIT}
	Input Text	${locator_tenderClaim.fieldPrice}	${fieldvalue}
	#go to the exit
	Wait Visibility And Click Element	${locator_tender.bid.BtnNext}
	Click If Visible	${locator_tender.complaint.btnSave}
	Wait Until Element Contains	css=div.step-info-title	3/3	${COMMONWAIT}


Змінити status
	[Arguments]  ${fieldvalue}
	[Return]  True
#	лише клікаємо зберегти, нічого не змінюючи


Скасувати цінову пропозицію
	[Arguments]  @{ARGUMENTS}
	[Documentation]
	...	${ARGUMENTS[0]} ==  username
	...	${ARGUMENTS[1]} ==  tenderId
	Switch To PMFrame
	Wait Enable And Click Element	${locator_tenderClaim.buttonCreate}
	Wait Enable And Click Element	${locator_tenderClaim.buttonCancel}
#TODO проверка на текст. Необходимо проверить и заменить
#    log to console  TODO проверка на текст. Необходимо проверить и заменить
#    debug
	Close Confirmation	Вашау заявку успішно скасовано!
	Switch To PMFrame
	Wait Until Element Is Enabled	${locator_tenderClaim.buttonCreate}	${COMMONWAIT}
	[Return]	${ARGUMENTS[1]}


Отримати пропозицію
	[Arguments]  ${username}  ${tender_uaid}
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td[4 and contains(., 'Недействительная')]	1
	${button_of_send_claim_text} =	Get text	${locator_tenderClaim.buttonCreate}
	${status} =						Set Variable	invalid
	${bid} =						get_bid_data	${status}
	[Return]	${bid}


Завантажити документ в ставку
	[Arguments]  ${user}  ${filePath}  ${tenderId}  ${doc_type}=documents
	Відкрити заявку
	Додати документ в ставку	${filePath}
	${upload_response} =	Зберегти доданий файл	${filePath}
	[Return]	${upload_response}


Додати документ в ставку
	[Arguments]  ${filePath}
	Wait Visibility And Click Element	css=div[ng-if='model.canAddFiles'] a
	Wait Visibility And Click Element	xpath=//div[contains(@ng-if, 'changeFile')]
	Choose File	id=afpFile	${filePath}
	Wait Visibility And Click Element	xpath=//a[contains(@ng-class, 'fileType')]
	Wait Visibility And Click Element	xpath=//li[contains(@ng-click, 'act.setFileType')][1]
	Wait Visibility And Click Element	xpath=//a[contains(@ng-class, 'lang')]
	Wait Visibility And Click Element	xpath=//li[contains(@class, 'lang')][2]


Зберегти доданий файл
	[Arguments]  ${filePath}
	Switch To PMFrame
	Wait Visibility And Click Element	css=button.error-button
	Wait For Ajax

	#go to the exit
	Switch To PMFrame
	Wait Visibility And Click Element	${locator_tender.bid.BtnNext}
	Wait Until Element Contains	css=div.step-info-title	2/3	10s
	Wait Visibility And Click Element	${locator_tender.bid.BtnNext}
	Click If Visible	id=btnSaveComplaint
	Wait Until Element Contains	css=div.step-info-title	3/3	10s

	Wait Visibility And Click Element	${locator_tenderClaim.buttonSend}
#TODO проверка на текст. Необходимо проверить и заменить
#    log to console  TODO проверка на текст. Необходимо проверить и заменить
#    debug
	Close confirmation	Ваша заявка була успішно збережена!

	#save file data
	Wait For Ajax
	Switch To PMFrame
	Wait Until Element Is Visible	${tender_data_status}	${COMMONWAIT}
	Wait Visibility And Click Element	xpath=//li[contains(@ng-class, 'lot-parts')]
	Wait Until Element Is Visible	css=table.bids tr	${COMMONWAIT}
	#switch to correct tab and find element
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td//img[contains(@src,'clip_icon.png')]	6
	Wait For Element With Reload	xpath=//table[@class='bids']//tr[1]/td//span[contains(., 'Відправлена')]	6

	#получим ссылку на файл, его id и дату
	Wait Visibility And Click Element	css=a[ng-click='act.showDocWin(b)']
	Wait For Ajax
	Wait Until Element Is Enabled	xpath=(//div[@ng-click='openUrl(file.url)'])[last()]	5s
	${dateModified} = 	Get text	xpath=(//span[contains(@class, 'file-tlm')])[last()]
	${url} = 	Execute Javascript	var scope = angular.element($("div[ng-click='openUrl(file.url)']")).last().scope(); return scope.file.uploadUrl
	Wait Visibility And Click Element	css=span[ng-click='act.hideModal()']
	${uploaded_file_data} = 	fill_file_data  ${url}  ${filePath}  ${dateModified}  ${dateModified}
	${upload_response} = 	Create Dictionary
	Set To Dictionary	${upload_response}	upload_response	${uploaded_file_data}
	[Return]	${upload_response}


Змінити документ в ставці
	[Arguments]  ${user}  ${filePath}  ${bidid}  ${docid}
	Відкрити заявку
	Switch To PMFrame
	Wait Visibility And Click Element	css=i.icon-edit
	Choose File	id=changeFile	${filePath}
	Wait For Ajax
	Wait Visibility And Click Element	xpath=//a[contains(@ng-class, 'lang')]
	Wait Visibility And Click Element	xpath=//li[contains(@class, 'lang')][2]
	${uploaded_file_data} =				Зберегти доданий файл	${filePath}
	[Return]  ${uploaded_file_data}


Змінити документацію в ставці
	[Arguments]  ${privat_doc}  ${bidid}  ${docid}
	Відкрити заявку
	Scroll Page To Element		css=button[ng-click='act.chooseFile()']

	Run Keyword					Змінити ${bidid.data.confidentiality} для файлу	${bidid}
	${file_name} =				Get text	xpath=(//span[@class='file-name ng-binding'])[last()]
	${uploaded_file_data} =		Зберегти доданий файл	${file_name}
	[Return]  ${uploaded_file_data}


Змінити buyerOnly для файлу
	[Arguments]  ${bidid}
	Wait Visibility And Click Element	xpath=(//div[@ng-if='model.canSecretFiles'])[last()]
	Wait Element Visibility And Input Text	css=textarea[ng-model='model.fvHideReason']	${bidid.data.confidentialityRationale}
	Wait Visibility And Click Element	xpath=//button[contains(@ng-click,'act.setFvHidden')]
	#TODO проверка на текст. Необходимо проверить и заменить
#    log to console  TODO проверка на текст. Необходимо проверить и заменить
#    debug
	Wait For Notification			Файл был успешно скрыт!


Обробити скаргу
	[Arguments]  @{ARGUMENTS}
	Fail  Функція не підтримується майданчиком


Отримати посилання на аукціон для глядача
	[Arguments]  ${user}  ${tenderId}
	Wait For Element With Reload	css=button#takepartLink	1
	Wait Visibility And Click Element	css=button#takepartLink
	Wait Until Element Is Visible	xpath=//a[contains(@href, 'https://auction-sandbox.openprocurement.org/tenders/')]  timeout=30
	${result} = 	Get Element Attribute	xpath=//a[contains(@href, 'https://auction-sandbox.openprocurement.org/tenders/')]@href
	[Return]  ${result}


Отримати посилання на аукціон для учасника
	[Arguments]  ${user}  ${tenderId}
	Wait For Element With Reload	css=button#takepartLink	1
	Wait Visibility And Click Element	css=button#takepartLink
	Wait Until Element Is Visible	css=div[ng-click='commonActions.sendRedir(bid.afpId)']	timeout=30
	${request_string} =	Convert To String
		...  return (function(){var link = angular.element($("div[ng-click='commonActions.sendRedir(bid.afpId)']")).last().scope().model.ad.auctionUrl; if(!link || link=='None'){return false;} else return true;})()
	Wait For Condition	${request_string}	${COMMONWAIT}
	${result} =	Execute Javascript	return angular.element($("div[ng-click='commonActions.sendRedir(bid.afpId)']")).last().scope().model.ad.auctionUrl
	[Return]  ${result}

Обрати додаткові класифікатори
    [Arguments]  ${scheme}  ${classificationId}
    Обрати схему  ${scheme}
    Обрати класифікатори  ${classificationId}


Обрати класифікатори
    [Arguments]  ${classificationId}
    Wait Visibility And Click Element  xpath=//section[@data-id='additionalClassifications']//span[@data-id='actChoose']
	Wait Until Element Is Visible	css=section[data-id='classificationTreeModal']	${COMMONWAIT}
	Wait Until Element Is Visible	css=input[data-id='query']	${COMMONWAIT}
	Wait Element Visibility And Input Text	css=input[data-id='query']	${classificationId}
	Wait Until Element Is Not Visible  css=.modal-body.tree.pm-tree
	Sleep  1
	Wait Visibility And Click Element	xpath=//div[@data-id='foundItem']//label[@for='found_${classificationId}']
	Wait Visibility And Click Element	css=[data-id='actConfirm']


Обрати схему
    [Arguments]  ${scheme}
    Wait Visibility And Click Element  css=[data-id='additionalClassifications'] .content-caption-info
    Sleep  1
    Wait Visibility And Click Element  xpath=//section[@data-id='schemeCheckModal']//label[@for='scheme_${scheme}']
    Wait Visibility And Click Element  xpath=//section[@data-id='schemeCheckModal']//button[@data-id='actConfirm']
    Sleep  1


#Custom Keywords
Login
	[Arguments]  ${username}
#	Wait Visibility And Click Element	xpath=//span[.='Вход']
	Wait Visibility And Click Element	css=a[data-target="#login_modal"]
	Wait Until Element Is Visible	id=p24__login__field	${COMMONWAIT}
	Execute Javascript	$('#p24__login__field').val('+${USERS.users['${username}'].login}')
#	Check If Element Stale	xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']
	Input Text	xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']	${USERS.users['${username}'].password}
	Wait Visibility And Click Element	xpath=//div[@id="login_modal" and @style='display: block;']//button[@type='submit']
	Wait Until Element Is Visible	css=ul.user-menu  timeout=30


Wait For Ajax
	Get Location
#	sleep				5s
#	Wait For Condition	return window.jQuery!=undefined && jQuery.active==0	60s


Wait Until Element Not Stale
	[Arguments]  ${locator}  ${time}
	sleep 			2s
	${left_time} =	Evaluate  ${time}-2
	${element_state} =	Check If Element Stale	${locator}
	run keyword if  ${element_state} and ${left_time} > 0	Wait Until Element Not Stale	${locator}	${left_time}


Check If Element Stale
	[Arguments]  ${locator}
	${element} =	Get Webelement	${locator}
	${element_state} =	is_element_not_stale	${element}
	[Return]  ${element_state}


Switch To Frame
	[Arguments]  ${frameId}
	Wait Until Element Is enabled	${frameId}	${COMMONWAIT}
	Select Frame					${frameId}


Wait Enable And Click Element
	[Arguments]  ${elementLocator}
	Wait Until Element Is enabled	${elementLocator}	${COMMONWAIT}
	Click Element					${elementLocator}
	Wait For Ajax


Wait Visibility And Click Element
	[Arguments]  ${elementLocator}
	Wait Until Element Is Visible	${elementLocator}	${COMMONWAIT}
	Click Element					${elementLocator}

Wait Element Visibility And Input Text
	[Arguments]  ${elementLocator}  ${input}
	Wait Until Element Is Visible	${elementLocator}	${COMMONWAIT}
	Input Text	${elementLocator}	${input}


Close Confirmation
	[Arguments]	${confirmation_text}
	Wait Until Element Is Visible		css=div.modal-body.info-div	${COMMONWAIT}
	Wait Until Element Contains			css=div.modal-body.info-div	${confirmation_text}	${COMMONWAIT}
	Wait Visibility And Click Element	css=button#btnClose
	Wait Until Element Is Not Visible	css=div.modal-body.info-div	${COMMONWAIT}


Close Confirmation In Editor
	[Arguments]	${confirmation_text}
	Wait Until Element Is Visible		css=div.modal-body.info-div	${COMMONWAIT}
	Wait Until Element Contains			css=div.modal-body.info-div	${confirmation_text}	${COMMONWAIT}
	Wait Visibility And Click Element	css=button[ng-click='close()']
	Wait Until Element Is Not Visible	css=div.modal-body.info-div	${COMMONWAIT}


Wait For Notification
	[Arguments]	${message_text}
	Wait Until Element Is Enabled		xpath=//div[@class='alert-info ng-scope ng-binding']	timeout=${COMMONWAIT}
	Wait Until Element Contains			xpath=//div[@class='alert-info ng-scope ng-binding']	${message_text}	timeout=10


Wait For Element Value
	[Arguments]	${locator}
	${cssLocator} =	Get Substring	${locator}	4
	Wait For Condition				return window.$($("${cssLocator}")).val()!='' && window.$($("${cssLocator}")).val()!='None'	${COMMONWAIT}
	${value}=	get value			${locator}


Wait For Sspecific Element Value
	[Arguments]	${locator}  ${value}
	${cssLocator} =	Get Substring	${locator}	4
	Wait For Condition				return window.$($("${cssLocator}")).val()=='${value}'	${COMMONWAIT}
	${value}=	get value			${locator}


Scroll Page To Element
	[Arguments]	${locator}
	${cssLocator} =		Run Keyword If	'css' in '${TEST_NAME}'	Get Substring	${locator}	4
		...  ELSE	Get Substring	${locator}	6
	${js_expresion} =	Run Keyword If	'css' in '${TEST_NAME}'	Convert To String	return window.$("${cssLocator}")[0].scrollIntoView()
		...  ELSE	Convert To String	return window.$x("${cssLocator}")[0].scrollIntoView()
	Sleep	2s


Wait For Tender
	[Arguments]	${tender_id}  ${education_type}
	Wait Until Keyword Succeeds	10min	10s	Try Search Tender	${tender_id}	${education_type}


Try Search Tender
	[Arguments]	${tender_id}  ${education_type}
	Switch To PMFrame
	Check Current Mode New Realisation
#	Check Current Mode	${education_type}

	#заполним поле поиска
	${text_in_search} =	Get Value	${locator_tenderSearch.searchInput}
	Run Keyword Unless	'${tender_id}' == '${text_in_search}'	Run Keywords	Clear Element Text	${locator_tenderSearch.searchInput}
	...   AND   sleep	1s
	...   AND   Input Text	${locator_tenderSearch.searchInput}	${tender_id}

	#выполним поиск
	Click Element	css=button#search-query-button
	Wait For Ajax Overflow Vanish
	Wait Until Element Is Enabled	id=${tender_id}	timeout=10
	[Return]	True


Check Current Mode
	[Arguments]	${education_type}=${True}
	privatmarket.Оновити сторінку з тендером
	#проверим правильный ли режим
	${current_type} =	Get text	${locator_tender.switchToDemo}
	${check_result} =	Run Keyword If	'Войти в демо-режим' in '${current_type}'	Set Variable  True
	Run Keyword If	${check_result} and ${education_type}	Run Keywords	Switch To Education Mode
	...   AND   Wait For Ajax
	...   AND   Wait Until Element Not Stale	${locator_tenderSearch.addTender}	40
	...   AND   Wait Until Element Is Enabled	${locator_tenderSearch.addTender}	timeout=${COMMONWAIT}


Check Current Mode New Realisation
	[Arguments]	${education_type}=${True}
	privatmarket.Оновити сторінку з тендером
	#проверим правильный ли режим
	Wait Until Element Is Visible	${locator_tender.switchToDemo}	${COMMONWAIT}
	${check_result} =  Run Keyword And Ignore Error	Wait Until Element Is Visible	${locator_tender.switchToDemo.message}	${COMMONWAIT}
	Run Keyword If	${check_result} != 'PASS'	Switch To Education Mode


Switch To Education Mode
	[Arguments]	${education_type}=${True}
	Wait Visibility And Click Element	${locator_tender.switchToDemo}
	Wait Until Element Is Visible	${locator_tender.switchToDemo.message}	${COMMONWAIT}


Reload And Switch To Tab
	[Arguments]  ${tab_number}
	Reload Page
	Switch To PMFrame
	Switch To Tab		${tab_number}
	Wait For Ajax


Switch To Tab
	[Arguments]  ${tab_number}
	${class} =	Get Element Attribute	xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]@class
	Run Keyword Unless	'white-icon' in '${class}'	Wait Visibility And Click Element	xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]


Wait For Element With Reload
	[Arguments]  ${locator}  ${tab_number}
	Wait Until Keyword Succeeds			5min	10s	Try Search Element	${locator}	${tab_number}


Try Search Element
	[Arguments]	${locator}  ${tab_number}
	Reload And Switch To Tab			${tab_number}
	Wait For Ajax
	Wait Until Element Is Enabled		${locator}	10
	[Return]	True


Wait For Ajax Overflow Vanish
	Wait Until Element Is Not Visible	${locator_tender.ajax_overflow}	${COMMONWAIT}


Chose UK language
	Switch To PMFrame
	Wait Until Element Is Visible	xpath=//a[.='uk']	10s
	Click Element	xpath=//a[.='uk']


Click If Visible
	[Arguments]	${locator}
	${is_visible} = 	Run Keyword And return Status	Wait Until Element Is Visible	${locator}	10s
	Return From Keyword If	'${is_visible}' == '${FALSE}'	${False}
	Click Element	${locator}
	Wait Until Element Is Not Visible	${locator}


Close notification
	Switch To PMFrame
	${notification_visibility} = 	Run Keyword And Return Status	Wait Until Element Is Visible	css=section[data-id='popupHelloModal'] span[data-id='actClose']	${COMMONWAIT}
	Run Keyword If	${notification_visibility}	Click Element	css=section[data-id='popupHelloModal'] span[data-id='actClose']
#	Wait Until Element Is Not Visible	css=section[data-id='popupHelloModal'] span[data-id='actClose']


Switch To PMFrame
    Unselect Frame
    Wait Until Element Is Visible  id=tenders  ${COMMONWAIT}
	Switch To Frame	id=tenders


Search By Query
	[Arguments]  ${element}  ${query}
	Wait Element Visibility And Input Text	${element}	${query}
	Wait Until Element Is Not Visible  css=.modal-body.tree.pm-tree
	Wait Until Element Is Enabled  xpath=//div[@data-id='foundItem']//label[@for='found_${query}']
	Wait Visibility And Click Element	xpath=//div[@data-id='foundItem']//label[@for='found_${query}']


Set Date And Time
	[Arguments]  ${element}  ${fild}  ${time_element}  ${date}
	Set Date	${element}	${fild}	${date}
	Set Time	${time_element}	${date}


Set Date
	[Arguments]  ${element}  ${fild}  ${date}
	Execute Javascript	var s = angular.element('[ng-controller=CreateProcurementCtrl]').scope(); s.model.ptr.${element}.${fild} = new Date(Date.parse("${date}")); s.model.prepareDateModel(s.model.ptr, '${element}'); s.$root.$apply()


Set Date In Item
	[Arguments]  ${index}  ${element}  ${fild}  ${date}
	Execute Javascript	var s = angular.element('[ng-controller=CreateProcurementCtrl]').scope(); s.model.ptr.items[${index}].${element}.${fild} = new Date(Date.parse("${date}")); s.model.prepareDateModel(s.model.ptr.items[${index}], '${element}'); s.$root.$apply()


Set Time
	[Arguments]  ${element}  ${date}
	${time} =	Get Regexp Matches	${date}	T(\\d{2}:\\d{2})	1
	Input Text	${element}	${time[0]}