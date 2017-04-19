*** Settings ***
Library  String
Library  DateTime
Library  Selenium2Library
Library  Collections
Library  DebugLibrary
Library  privatmarket_service.py

*** Variables ***
${COMMONWAIT}  40s
${locator_tenderSearch.searchInput}  css=input#search-query-input
${locator_tender.switchToDemo}  css=a#test-model-switch
${locator_tender.switchToDemoMessage}  css=.test-mode-popup-content.ng-binding
${locator_tenderSearch.addTender}  css=button[ng-click='template.newTender()']
${locator_lotAdd.postalCode}  css=input[data-id='postalCode']
${locator_lotAdd.countryName}  css=input[data-id='countryName']
${locator_lotAdd.region}  css=input[data-id='region']
${locator_lotAdd.locality}  css=input[data-id='locality']
${locator_lotAdd.streetAddress}  css=input[data-id='streetAddress']
${locator_tenderAdd.btnSave}  css=button[data-id='actSave']
${locator_tenderCreation.buttonSend}  css=button[data-id='actSend']
${locator_tenderClaim.buttonCreate}  css=button[ng-click='commonActions.createAfp()']

${tender_data_title}  xpath=//div[contains(@class,'title-div')]
${tender_data_description}  id=tenderDescription
${tender_data_procurementMethodType}  id=tenderType
${tender_data_status}  id=tenderStatus
${tender_data_value.amount}  id=tenderBudget
${tender_data_value.currency}  id=tenderBudgetCcy
${tender_data_value.valueAddedTaxIncluded}  id=tenderBudgetTax
${tender_data_tenderID}  id=tenderId
${tender_data_procuringEntity.name}  css=a[ng-click='commonActions.openCard()']
${tender_data_enquiryPeriod.startDate}  xpath=(//span[@ng-if='p.bd'])[1]
${tender_data_enquiryPeriod.endDate}  xpath=(//span[contains(@ng-if, 'p.ed')])[1]
${tender_data_tenderPeriod.startDate}  xpath=(//span[@ng-if='p.bd'])[2]
${tender_data_tenderPeriod.endDate}  xpath=(//span[contains(@ng-if, 'p.ed')])[2]
${tender_data_auctionPeriod.startDate}  xpath=(//span[@ng-if='p.bd'])[3]
${tender_data_minimalStep.amount}  css=div#lotMinStepAmount
${tender_data_documentation.title}  xpath=//div[@class='file-descriptor']/span[1]

${tender_data_item.description}  //div[@class='description']//span)
${tender_data_item.deliveryDate.startDate}  //div[@ng-if='adb.deliveryDate.startDate']/div[2])
${tender_data_item.deliveryDate.endDate}  //div[@ng-if='adb.deliveryDate.endDate']/div[2])
${tender_data_item.deliveryLocation.latitude}  //span[contains(@class, 'latitude')])
${tender_data_item.deliveryLocation.longitude}  //span[contains(@class, 'longitude')])
${tender_data_item.deliveryAddress.countryName}  //span[@id='countryName'])
${tender_data_item.deliveryAddress.postalCode}  //span[@id='postalCode'])
${tender_data_item.deliveryAddress.region}  //span[@id='region'])
${tender_data_item.deliveryAddress.locality}  //span[@id='locality'])
${tender_data_item.deliveryAddress.streetAddress}  //span[@id='streetAddress'])
${tender_data_item.classification.scheme}  //span[contains(@class, 'cl-scheme')])[1]
${tender_data_item.classification.id}  //span[contains(@class, 'cl-id')])[1]
${tender_data_item.classification.description}  //span[contains(@class, 'cl-name')])[1]
${tender_data_item.additionalClassifications[0].scheme}  //span[contains(@class, 'cl-scheme')])[2]
${tender_data_item.additionalClassifications[0].id}  //span[contains(@class, 'cl-id')])[2]
${tender_data_item.additionalClassifications[0].description}  //span[contains(@class, 'cl-name')])[2]
${tender_data_item.unit.name}  //div[@ng-if='adb.quantity']/div[2]/span[2])
${tender_data_item.unit.code}  //div[@ng-if='adb.quantity']/div[2]/span[2])
${tender_data_item.quantity}  //div[@ng-if='adb.quantity']/div[2]/span)

${tender_data_lot.title}  //div[@id='lot-title'])
${tender_data_lot.description}  //section[contains(@class, 'description marged')])
${tender_data_lot.value.amount}  //div[@id='lotAmount'])
${tender_data_lot.value.currency}  //div[@id='lotCcy'])
${tender_data_lot.value.valueAddedTaxIncluded}  //div[@id='lotTax'])
${tender_data_lot.minimalStep.amount}  //div[@id='lotMinStepAmount'])
${tender_data_lot.minimalStep.currency}  //div[@id='lotMinStepCcy'])
${tender_data_lot.minimalStep.valueAddedTaxIncluded}  //div[@id='lotMinStepTax'])

${tender_data_question.title}  //span[contains(@class, 'question-title')])
${tender_data_question.description}  //div[@class='question-div']/div[1])
${tender_data_question.answer}  //div[@class='question-div question-expanded']/div[1])

${tender_data_feature.featureOf}  /../../../*[1]


*** Keywords ***
Підготувати дані для оголошення тендера
    [Arguments]  ${username}  ${tender_data}  ${role_name}
    ${tender_data.data}=  Run Keyword If  'PrivatMarket_Owner' == '${username}'  privatmarket_service.modify_test_data  ${tender_data.data}
    ${adapted.data}=  privatmarket_service.modify_test_data  ${tender_data.data}
    [Return]  ${tender_data}


Підготувати клієнт для користувача
    [Arguments]  ${username}
    [Documentation]  Відкрити брaвзер, створити обєкт api wrapper, тощо
    ${service args}=  Create List  --ignore-ssl-errors=true  --ssl-protocol=tlsv1
    ${browser}=  Convert To Lowercase  ${USERS.users['${username}'].browser}
    ${disabled}  Create List  Chrome PDF Viewer
    ${prefs}  Create Dictionary  download.default_directory=${OUTPUT_DIR}  plugins.plugins_disabled=${disabled}
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method  ${chrome_options}  add_argument  --allow-running-insecure-content
    Call Method  ${chrome_options}  add_argument  --disable-web-security
    Call Method  ${chrome_options}  add_argument  --nativeEvents\=false
    Call Method  ${chrome_options}  add_experimental_option  prefs  ${prefs}
    #Call Method  ${chrome_options}  add_argument  --user-data-dir\=/home/lugovskoy/.config/google-chrome/Default

    #Для Viewer'а нужен хром, т.к. на хром настроена автоматическая закачка файлов
    Run Keyword If  '${username}' == 'PrivatMarket_Viewer'  Create WebDriver  Chrome  chrome_options=${chrome_options}  alias=${username}
    Run Keyword If  '${username}' == 'PrivatMarket_Owner'  Create WebDriver  Chrome  chrome_options=${chrome_options}  alias=${username}
    Run Keyword If  '${username}' == 'PrivatMarket_Provider'  Create WebDriver  Firefox  chrome_options=${chrome_options}  alias=${username}
    Go To  ${USERS.users['${username}'].homepage}

    #Open Browser  ${USERS.users['${username}'].homepage}  ${browser}  alias=${username}
    Set Window Size  @{USERS.users['${username}'].size}
    Set Selenium Implicit Wait  10s
    Login  ${username}
    Switch To PMFrame


Пошук тендера по ідентифікатору
    [Arguments]  ${username}  ${tenderId}
    Go To  ${USERS.users['${username}'].homepage}
    Close notification
    Wait Until Element Is Visible  ${locator_tenderSearch.searchInput}  timeout=${COMMONWAIT}

    ${suite_name}=  Convert To Lowercase  ${SUITE_NAME}
    ${education_type}=  Run Keyword If  'negotiation' in '${suite_name}'  Set Variable  False
        ...  ELSE  Set Variable  True

    Wait For Tender  ${tenderId}  ${education_type}
    Wait Visibility And Click Element  css=tr#${tenderId}
    Sleep  5s
    Switch To PMFrame
    Wait Until Element Is Visible  ${tender_data_title}  ${COMMONWAIT}


Створити тендер
    [Arguments]  ${username}  ${tender_data}
    ${presence}=  Run Keyword And Return Status  List Should Contain Value  ${tender_data.data}  lots
    @{lots}=  Run Keyword If  ${presence}  Get From Dictionary  ${tender_data.data}  lots
    ${presence}=  Run Keyword And Return Status  List Should Contain Value  ${tender_data.data}  items
    @{items}=  Run Keyword If  ${presence}  Get From Dictionary  ${tender_data.data}  items
    ${presence}=  Run Keyword And Return Status  List Should Contain Value  ${tender_data.data}  features
    @{features}=  Run Keyword If  ${presence}  Get From Dictionary  ${tender_data.data}  features
    Switch To PMFrame
    Close notification
    Wait Until Element Is Visible  ${locator_tenderSearch.searchInput}  ${COMMONWAIT}
    Check Current Mode New Realisation

#go to form
    Wait Visibility And Click Element  ${locator_tenderSearch.addTender}
    Unselect Frame
    Wait Until Page Contains Element  id=sender-analytics  ${COMMONWAIT}
    Switch To PMFrame
    Wait Visibility And Click Element  xpath=(//div[@class='big-button-step'])[1]

#step 0
    #we should add choosing of procurementMethodType
    Switch To PMFrame
    Wait Element Visibility And Input Text  css=input[data-id='procurementName']  ${tender_data.data.title}
    Wait Element Visibility And Input Text  css=textarea[data-id='procurementDescription']  ${tender_data.data.description}

    #CPV
    Wait Visibility And Click Element  xpath=(//span[@data-id='actChoose'])[1]
    Wait Until Element Is Visible  css=section[data-id='classificationTreeModal']  ${COMMONWAIT}
    Wait Until Element Is Visible  css=input[data-id='query']  ${COMMONWAIT}
    Search By Query  css=input[data-id='query']  ${items[0].classification.id}
    Wait Visibility And Click Element  css=button[data-id='actConfirm']
    Run Keyword If  '${items[0].classification.id}' == '99999999-9'  Обрати додаткові класифікатори   ${items[0].additionalClassifications[0].scheme}   ${items[0].additionalClassifications[0].id}

    #date
    Switch To PMFrame
    Wait Until Element Is Visible  css=input[ng-model='model.ptr.enquiryPeriod.sd.d']  ${COMMONWAIT}
    Set Date And Time  enquiryPeriod  startDate  css=span[data-id='ptrEnquiryPeriodStartDate'] input[ng-model='inputTime']  ${tender_data.data.enquiryPeriod.startDate}
    Wait Until Element Is Visible  css=span[data-id='ptrEnquiryPeriodEndDate'] input[ng-model='inputTime']  ${COMMONWAIT}
    Set Date And Time  enquiryPeriod  endDate  css=span[data-id='ptrEnquiryPeriodEndDate'] input[ng-model='inputTime']  ${tender_data.data.enquiryPeriod.endDate}
    Wait Until Element Is Visible  css=span[data-id='ptrTenderPeriodStartDate'] input[ng-model='inputTime']  ${COMMONWAIT}
    Set Date And Time  tenderPeriod  startDate  css=span[data-id='ptrTenderPeriodStartDate'] input[ng-model='inputTime']  ${tender_data.data.tenderPeriod.startDate}
    Wait Until Element Is Visible  css=span[data-id='ptrTenderPeriodEndDate'] input[ng-model='inputTime']  ${COMMONWAIT}
    Set Date And Time  tenderPeriod  endDate  css=span[data-id='ptrTenderPeriodEndDate'] input[ng-model='inputTime']  ${tender_data.data.tenderPeriod.endDate}

    #procuringEntityAddress
    Wait Element Visibility And Input Text  ${locator_lotAdd.postalCode}  ${tender_data.data.procuringEntity.address.postalCode}
    Wait Element Visibility And Input Text  ${locator_lotAdd.countryName}  ${tender_data.data.procuringEntity.address.countryName}
    Wait Element Visibility And Input Text  ${locator_lotAdd.region}  ${tender_data.data.procuringEntity.address.region}
    Wait Element Visibility And Input Text  ${locator_lotAdd.locality}  ${tender_data.data.procuringEntity.address.locality}
    Wait Element Visibility And Input Text  ${locator_lotAdd.streetAddress}  ${tender_data.data.procuringEntity.address.streetAddress}

    #contactPoint
    Wait Element Visibility And Input Text  css=input[data-id='name']  ${tender_data.data.procuringEntity.contactPoint.name}
    ${modified_phone}=  Remove String  ${tender_data.data.procuringEntity.contactPoint.telephone}  ${SPACE}
    ${modified_phone}=  Remove String  ${modified_phone}  -
    ${modified_phone}=  Remove String  ${modified_phone}  (
    ${modified_phone}=  Remove String  ${modified_phone}  )
    ${modified_phone}=  Set Variable If  '+38' in '${modified_phone}'  ${modified_phone}  +38067${modified_phone}
    ${modified_phone}=  Get Substring  ${modified_phone}  0  13
    Wait Element Visibility And Input Text  css=input[data-id='telephone']  ${modified_phone}
    Wait Element Visibility And Input Text  css=input[data-id='email']  ${USERS.users['${username}'].email}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}

#step 1
    Додати lots  ${lots}

#step 2
    ${count}=  Get Length  ${items}
    Run Keyword If  ${count} > 0  Додати items  ${items}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait Until Element Is Visible  css=section[data-id='step3']  ${COMMONWAIT}

#step 3
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}

#step 4
    Wait Until Element Is Visible  css=section[data-id='step4']  ${COMMONWAIT}

    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}

#step 5
    Wait Until Element Is Visible  css=section[data-id='step5']  ${COMMONWAIT}
    Sleep  3s
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Switch To PMFrame
    Wait For Element With Reload  xpath=//div[@id='tenderStatus' and contains(., 'Період уточнень')]  1
    ${tender_id}=  Get Text  css=div#tenderId
    [Return]  ${tender_id}


Додати lots
    [Arguments]  ${lots}
    ${lots_count}=  Get Length  ${lots}
    Switch To PMFrame

    : FOR    ${index}    IN RANGE    0    ${lots_count}
    \    Wait Element Visibility And Input Text  css=input[data-id='title']  ${lots[${index}].title}
    \    Wait Element Visibility And Input Text  css=textarea[data-id='description']  ${lots[${index}].description}
    \    ${value_amount}=  privatmarket_service.convert_float_to_string  ${lots[${index}].value.amount}
    \    ${minimalStep_amount}=  Convert to String  ${lots[${index}].minimalStep.amount}
    \    Wait Element Visibility And Input Text  css=input[data-id='valueAmount']  ${value_amount}
    \    Sleep  3s
    \    Wait Element Visibility And Input Text  css=input[data-id='minimalStepAmount']  ${minimalStep_amount}
    \    Wait Visibility And Click Element  css=div.lot-guarantee label
    \    Wait Element Visibility And Input Text  css=input[data-id='guaranteeAmount']  1


Додати items
    [Arguments]  ${items}
    ${items_count}=  Get Length  ${items}
    Switch To PMFrame
    : FOR    ${index}    IN RANGE    0    ${items_count}
    \    Wait Element Visibility And Input Text  css=input[ng-model='item.description']  ${items[${index}].description}
    \    Wait Element Visibility And Input Text  css=input[data-id='quantity']  ${items[${index}].quantity}
    \    ${unitName}=  privatmarket_service.get_unit_name  ${items[${index}].unit.name}
    \    Wait Visibility And Click Element  xpath=//select[@data-id='unit']/option[text()='${unitName}']
    \    ${deliveryStartDate}=  Get Regexp Matches  ${items[${index}].deliveryDate.startDate}  (\\d{4}-\\d{2}-\\d{2})
    \    ${deliveryStartDate}=  Convert Date  ${deliveryStartDate[0]}  result_format=%d-%m-%Y
    \    ${deliveryEndDate}=  Get Regexp Matches  ${items[${index}].deliveryDate.endDate}  (\\d{4}-\\d{2}-\\d{2})
    \    ${deliveryEndDate}=  Convert Date  ${deliveryEndDate[0]}  result_format=%d-%m-%Y
    \    Wait Visibility And Click Element  xpath=//input[contains(@ng-model, 'item.adressTypeMode')][1]
    \    Wait Element Visibility And Input Text  ${locator_lotAdd.postalCode}  ${items[${index}].deliveryAddress.postalCode}
    \    Wait Element Visibility And Input Text  ${locator_lotAdd.countryName}  ${items[${index}].deliveryAddress.countryName}
    \    Wait Element Visibility And Input Text  ${locator_lotAdd.region}  ${items[${index}].deliveryAddress.region}
    \    Wait Element Visibility And Input Text  ${locator_lotAdd.locality}  ${items[${index}].deliveryAddress.locality}
    \    Wait Element Visibility And Input Text  ${locator_lotAdd.streetAddress}  ${items[${index}].deliveryAddress.streetAddress}
    \    Wait Until Element Is Visible  css=input[ng-model='item.deliveryDate.ed.d']  ${COMMONWAIT}
    \    Set Date In Item  ${index}  deliveryDate  startDate  ${items[${index}].deliveryDate.startDate}
    \    Set Date In Item  ${index}  deliveryDate  endDate  ${items[${index}].deliveryDate.endDate}


Оновити сторінку з тендером
    [Arguments]  @{ARGUMENTS}
    [Documentation]
    ...  ${ARGUMENTS[0]} == username
    ...  ${ARGUMENTS[1]} == tenderId
    Reload Page
    Sleep  2s
    Switch To PMFrame


Внести зміни в тендер
    [Arguments]  ${user_name}  ${tenderId}  ${parameter}  ${value}
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Switch To PMFrame
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}
    #Switch To PMFrame
    Sleep  4s
    Unselect Frame
    Wait Visibility And Click Element  css=.modal.in .popup-close
    Switch To PMFrame
    Wait Element Visibility And Input Text  css=textarea[data-id='procurementDescription']  ${value}
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait Until Element Is Visible  css=section[data-id='step2']  ${COMMONWAIT}
    Wait Visibility And Click Element  css=#tab_4 a
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}

    #Дождемся подтверждения и обновим страницу, поскольку тут не выходит его закрыть
    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
    Wait Until Element Contains  css=div.modal-body.info-div  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.  ${COMMONWAIT}
    Reload Page


Завантажити документ
    [Arguments]  ${user_name}  ${filepath}  ${tenderId}
    #перейдем к редактированию
    Wait For Element With Reload  ${locator_tenderClaim.buttonCreate}  1
    Wait Visibility And Click Element  ${locator_tenderClaim.buttonCreate}

    #откроем нужную вкладку
    Wait Visibility And Click Element  css=#tab_3 a

    #загрузим файл
    Wait Visibility And Click Element  css=label[for='documentation_tender_yes']
    Wait Visibility And Click Element  css=div.file-loader a

    Wait Visibility And Click Element  css=div[ng-if='!model.file.title']
    Choose File  id=afpFile  ${filePath}
    Sleep  5s
    Wait Visibility And Click Element  xpath=//a[contains(@ng-class, 'file.currFileVfvError')]
    Wait Visibility And Click Element  xpath=//li[contains(@ng-click, 'setFileType')][1]
    Wait Visibility And Click Element  xpath=//a[contains(@ng-class, 'file.currFileVfvError')]
    Wait Visibility And Click Element  xpath=//button[contains(@ng-click, 'addFileFunction')]
    Wait Visibility And Click Element  ${locator_tenderAdd.btnSave}
    Wait Until Element Is Visible  css=section[data-id='step5']  ${COMMONWAIT}
    Wait Visibility And Click Element  ${locator_tenderCreation.buttonSend}

#Дождемся подтверждения и обновим страницу, поскольку тут не выходит его закрыть
    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
    Close Confirmation In Editor  Закупівля поставлена в чергу на відправку в ProZorro. Статус закупівлі Ви можете відстежувати в особистому кабінеті.
    Sleep  180s


Отримати інформацію із тендера
    [Arguments]  ${user_name}  ${tender_uaid}  ${field_name}
    Switch To PMFrame
    Wait Until Element Is Visible  ${tender_data_title}  ${COMMONWAIT}

    Відкрити детальну інформацию по позиціям

    #get information
    ${result}=  Отримати інформацію зі сторінки  ${tender_uaid}  ${field_name}
    [Return]  ${result}


Відкрити детальну інформацию по позиціям
    #check if extra information is already opened
    ${element_class}=  Get Element Attribute  xpath=//li[contains(@ng-class, 'description')]@class
    Run Keyword IF  'checked-nav' in '${element_class}'  Return From Keyword  True
    Wait Visibility And Click Element  xpath=//li[contains(@ng-class, 'description')]
    Wait Until Element Is Visible  xpath=//section[@class='description marged ng-binding']  ${COMMONWAIT}

    ${elements}=  Get Webelements  css=.lot-info .description a
    ${count}=  Get_Length  ${elements}
    :FOR  ${item}  In Range  0  ${count}
    \  ${item}=  privatmarket_service.sum_of_numbers  ${item}  1
    \  ${class}=  Get Element Attribute  xpath=(//div[@class='lot-info']//div[@class='description']/a)[${item}]@class
    \  Run Keyword Unless  'checked-item' in '${class}'  Click Element  xpath=(//div[@class='lot-info']//div[@class='description']/a)[${item}]


Отримати інформацію зі сторінки
    [Arguments]  ${base_tender_uaid}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'value.amount'  Convert Amount To Number  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'value.currency'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'value.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'enquiryPeriod.startDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'enquiryPeriod.endDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'tenderPeriod.startDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'tenderPeriod.endDate'  Отримати дату та час  ${field_name}  1
    Run Keyword And Return If  '${field_name}' == 'minimalStep.amount'  Convert Amount To Number  ${field_name}
    Run Keyword And Return If  '${field_name}' == 'status'  Отримати інформацію з ${field_name}  ${field_name}

    Wait Until Element Is Visible  ${tender_data_${field_name}}  ${COMMONWAIT}
    ${result_full}=  Get Text  ${tender_data_${field_name}}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із лоту
    [Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
    ${className}=  Get Element Attribute  xpath=//section[@id='lotSection']/section[contains(., '${object_id}')]//li[1]@class
    Run Keyword If  '${className}' == 'simple-nav_item active'  Wait Visibility And Click Element  //section[@id='lotSection']/section[contains(., '${object_id}')]//li[1]/a
    ${element}=  Set Variable  xpath=(//section[@id='lotSection']/section[contains(., '${object_id}')]${tender_data_lot.${field_name}}

    Run Keyword And Return If  '${field_name}' == 'value.amount'  Convert Amount To Number  ${element}
    Run Keyword And Return If  '${field_name}' == 'value.currency'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'value.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'minimalStep.amount'  Отримати суму  ${element}
    Run Keyword And Return If  '${field_name}' == 'minimalStep.currency'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'minimalStep.valueAddedTaxIncluded'  Отримати інформацію з ${field_name}  ${element}

    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із предмету
    [Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
    ${info}=  Set Variable  xpath=//section[contains(., '${object_id}') and contains(@id, 'lotSection')]/section//div[@class='info-item-val']/div[@class='description']/a
    ${info_class}=  Get Element Attribute  ${info}@class
    Run Keyword Unless  'checked-item' in '${info_class}'  Click Element  ${info}

    ${element}=  Set Variable  xpath=(//section[contains(., '${object_id}') and contains(@id, 'lotSection')]/section${tender_data_item.${field_name}}

    Run Keyword And Return If  '${field_name}' == 'deliveryDate.startDate'  Отримати дату та час  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'deliveryDate.endDate'  Отримати дату та час  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'deliveryLocation.latitude'  Отримати число  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'deliveryLocation.longitude'  Отримати число  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'additionalClassifications[0].scheme'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'classification.scheme'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'unit.name'  Отримати інформацію з ${field_name}  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'unit.code'  Отримати інформацію з ${field_name}  ${element}
    Run Keyword And Return If  '${field_name}' == 'quantity'  Отримати суму  ${element}


    Wait Until Element Is Visible  ${element}  timeout=${COMMONWAIT}
    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із запитання
    [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
    ${element}=  Set Variable  xpath=(//div[contains(@class, 'faq') and contains(., '${question_id}')]${tender_data_question.${field_name}}
    Wait For Element With Reload  ${element}  2
    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати інформацію із документа
    [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
    Wait For Element With Reload  xpath=//div[@class='file-descriptor']/span[contains(., '${doc_id}')]  1
    Wait Until Element Is Visible  xpath=//div[@class='file-descriptor']/span[contains(., '${doc_id}')]  ${COMMONWAIT}
    ${result}=  Get Text  xpath=//div[@class='file-descriptor']/span[contains(., '${doc_id}')]
    [Return]  ${result}


Отримати інформацію із нецінового показника
    [Arguments]  ${username}  ${tender_uaid}  ${object_id}  ${field_name}
    Відкрити детальну інформацию по позиціям

    ${element}=  Set Variable IF
        ...  '${field_name}' == 'featureOf'  xpath=//div[contains(@class, 'feature name') and contains(., '${object_id}')]${tender_data_feature.${field_name}}
        ...  xpath=//div[contains(@class, 'feature name') and contains(., '${object_id}')]

    Run Keyword And Return If  '${field_name}' == 'title'  Отримати інформацію з feature  ${element}  0
    Run Keyword And Return If  '${field_name}' == 'description'  Отримати інформацію з feature  ${element}  1
    Run Keyword And Return If  '${field_name}' == 'featureOf'  Отримати інформацію з ${field_name}  ${element}

    Wait Until Element Is Visible  ${element}  timeout=${COMMONWAIT}
    ${result_full}=  Get Text  ${element}
    ${result}=  Strip String  ${result_full}
    [Return]  ${result}


Отримати документ до лоту
    [Arguments]  ${username}  ${tender_uaid}  ${lot_id}  ${doc_id}
    ${file_name}=  privatmarket.Отримати документ  ${username}  ${tender_uaid}  ${doc_id}
    [Return]  ${file_name}

Отримати документ
    [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
    Wait For Element With Reload  xpath=//div[@class='file-descriptor']/span[contains(., '${doc_id}')]  1
    Wait Visibility And Click Element  xpath=//div[@class='file-descriptor']/span[contains(., '${doc_id}')]
    # Добален слип, т.к. док не успевал загрузиться
    sleep  20s
    ${file_name_full}=  Get Text  xpath=//div[@class='file-descriptor']/span[contains(., '${doc_id}')]
    ${file_name}=  Strip String  ${file_name_full}
    [Return]  ${file_name}


Отримати посилання на аукціон для глядача
    [Arguments]  ${user}  ${tenderId}
    Wait For Element With Reload  css=button#takepartLink  1
    Wait Visibility And Click Element  css=button#takepartLink
    Wait Until Element Is Visible  xpath=//a[contains(@href, 'https://auction-sandbox.openprocurement.org/tenders/')]  timeout=30
    ${result}=  Get Element Attribute  xpath=//a[contains(@href, 'https://auction-sandbox.openprocurement.org/tenders/')]@href
    [Return]  ${result}


Відповісти на запитання
    [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
    Switch To PMFrame
    Switch To Tab  2
    Wait For Element With Reload  xpath=//button[contains(@ng-click, 'act.answerFaq')]  2
    Wait Visibility And Click Element  xpath=//button[contains(@ng-click, 'act.answerFaq')]
    Wait Element Visibility And Input Text  id=questionAnswer  ${answer_data.data.answer}
    Sleep  2s
    Wait Visibility And Click Element  id=btnSendAnswer
    Wait For Notification  Ваша відповідь успішно відправлена!
    Wait Visibility And Click Element  css=span[ng-click='act.hideModal()']
    Wait Until Element Is Not Visible  id=questionAnswer  timeout=20
    #этот слип нужен, т.к. нет синхронизации и квинта ищет ответ в следующем тесте... а его нет пока не синхранизируемся
    Sleep  90s


Отримати інформацію з value.currency
    [Arguments]  ${element_name}
    ${currency}=  Отримати строку  ${element_name}  0
    ${currency_type}=  get_currency_type  ${currency}
    [Return]  ${currency_type}


Отримати інформацію з value.valueAddedTaxIncluded
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з minimalStep.currency
    [Arguments]  ${element_name}
    ${currency}=  Отримати строку  ${element_name}  0
    ${currency_type}=  get_currency_type  ${currency}
    [Return]  ${currency_type}


Отримати інформацію з minimalStep.valueAddedTaxIncluded
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з типу податку
    [Arguments]  ${element}
    ${value_added_tax_included}=  Get text  ${element}
    ${result}=  Set Variable If  'з ПДВ' in '${value_added_tax_included}'  True
    ${result}=  Convert To Boolean  ${result}
    [Return]  ${result}


Отримати інформацію з unit.code
    [Arguments]  ${element}
    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    ${result}=  privatmarket_service.get_unit_code  ${result_full}
    [Return]  ${result}


Отримати інформацію з quantity
    [Arguments]  ${element_name}
    ${result_full}=  Get Text  ${element_name}
    ${result}=  Strip String  ${result_full}
    ${result}=  Replace String  ${result}  .00  ${EMPTY}
    ${result}=  Strip String  ${result}
    [Return]  ${result}


Отримати інформацію з classification.scheme
    [Arguments]  ${element}
    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    ${result}=  privatmarket_service.get_classification_type  ${result_full}
    [Return]  ${result}


Отримати інформацію з additionalClassifications[0].scheme
    [Arguments]  ${element}
    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    ${result}=  privatmarket_service.get_classification_type  ${result_full}
    [Return]  ${result}


Отримати інформацію з status
    [Arguments]  ${element_name}
    privatmarket.Оновити сторінку з тендером
    Wait Until Element Is Visible  ${tender_data_${element_name}}  ${COMMONWAIT}
    #Added sleep, becource we taketext in status bar
    Sleep  5s
    ${status_name}=  Get text  ${tender_data_${element_name}}
    ${status_type}=  privatmarket_service.get_status_type  ${status_name}
    [Return]  ${status_type}


Отримати інформацію з feature
    [Arguments]  ${element}  ${id}
    Wait For Element With Reload  ${element}  1
    ${result_full}=  Отримати текст елемента  ${element}
    ${result_full}=  Strip String  ${result_full}
    ${values_list}=  Split String  ${result_full}  \n
    ${result}=  Set Variable  ${values_list[${id}]}
    [Return]  ${result}


Отримати інформацію з featureOf
    [Arguments]  ${element}
    ${text}=  Отримати текст елемента  ${element}
    ${result}=  Set Variable If
    ...  'по закупівлі' in '${text}'  tenderer
    ...  'по позиції' in '${text}'  item
    ...  'по лоту' in '${text}'  lot
    [Return]  ${result}




Отримати строку
    [Arguments]  ${element_name}  ${position_number}
    ${result_full}=  Отримати текст елемента  ${element_name}
    ${result}=  Strip String  ${result_full}
    ${result}=  Replace String  ${result}  ,  ${EMPTY}
    ${values_list}=  Split String  ${result}
    ${result}=  Strip String  ${values_list[${position_number}]}  mode=both  characters=:
    [Return]  ${result}


Отримати текст елемента
    [Arguments]  ${element_name}
    ${temp_name}=  Remove String  ${element_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
        ...  ${tender_data_${element_name}}

    Wait Until Element Is Visible  ${element}
    ${result_full}=  Get Text  ${element}
    [Return]  ${result_full}


Отримати дату та час
    [Arguments]  ${element_name}  ${shift}
    ${result_full}=  Отримати текст елемента  ${element_name}
    ${work_string}=  Replace String  ${result_full}  ${SPACE},${SPACE}  ${SPACE}
    ${work_string}=  Replace String  ${result_full}  ,${SPACE}  ${SPACE}
    ${values_list}=  Split String  ${work_string}
    ${day}=  Convert To String  ${values_list[0 + ${shift}]}
    ${month}=  privatmarket_service.get_month_number  ${values_list[1 + ${shift}]}
    ${month}=  Set Variable If  ${month} < 10  0${month}
    ${year}=  Convert To String  ${values_list[2 + ${shift}]}
    ${time}=  Convert To String  ${values_list[3 + ${shift}]}
    ${date}=  Convert To String  ${year}-${month}-${day} ${time}
    ${result}=  privatmarket_service.get_time_with_offset  ${date}
    [Return]  ${result}


Отримати суму
    [Arguments]  ${element_name}
    ${result}=  Отримати текст елемента  ${element_name}
    ${result}=  Remove String  ${result}  ${SPACE}
    ${result}=  Replace String  ${result}  ,  .
    ${result}=  Convert To Number  ${result}
    [Return]  ${result}


Отримати число
    [Arguments]  ${element_name}  ${position_number}
    ${value}=  Отримати строку  ${element_name}  ${position_number}
    ${result}=  Convert To Number  ${value}
    [Return]  ${result}


Отримати класифікацію
    [Arguments]  ${element_name}
    ${result_full} =  Отримати текст елемента  ${element_name}
    ${reg_expresion} =  Set Variable  [0-9A-zА-Яа-яёЁЇїІіЄєҐґ\\s\\:]+\: \\w+[\\d\\.\\-]+ ([А-Яа-яёЁЇїІіЄєҐґ\\s;,\\"_\\(\\)\\.]+)
    ${result} =  Get Regexp Matches  ${result_full}  ${reg_expresion}  1
    [Return]  ${result[0]}


Отримати інформацію з unit.name
    [Arguments]  ${element_name}  ${position_number}
    ${result_full}=  Отримати строку  ${element_name}  ${position_number}
    ${result}=  privatmarket_service.get_unit_name  ${result_full}
    [Return]  ${result}


Обрати додаткові класифікатори
    [Arguments]  ${scheme}  ${classificationId}
    Обрати схему  ${scheme}
    Обрати класифікатори  ${classificationId}


Обрати класифікатори
    [Arguments]  ${classificationId}
    Wait Visibility And Click Element  xpath=//section[@data-id='additionalClassifications']//span[@data-id='actChoose']
    Wait Until Element Is Visible  css=section[data-id='classificationTreeModal']  ${COMMONWAIT}
    Wait Until Element Is Visible  css=input[data-id='query']  ${COMMONWAIT}
    Wait Element Visibility And Input Text  css=input[data-id='query']  ${classificationId}
    Wait Until Element Is Not Visible  css=.modal-body.tree.pm-tree
    Sleep  1
    Wait Visibility And Click Element  xpath=//div[@data-id='foundItem']//label[@for='found_${classificationId}']
    Wait Visibility And Click Element  css=[data-id='actConfirm']


Обрати схему
    [Arguments]  ${scheme}
    Wait Visibility And Click Element  css=[data-id='additionalClassifications'] .content-caption-info
    Sleep  1
    Wait Visibility And Click Element  xpath=//section[@data-id='schemeCheckModal']//label[@for='scheme_${scheme}']
    Wait Visibility And Click Element  xpath=//section[@data-id='schemeCheckModal']//button[@data-id='actConfirm']
    Sleep  1


Close notification
    Switch To PMFrame
    ${notification_visibility}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=section[data-id='popupHelloModal'] span[data-id='actClose']
    Run Keyword If  ${notification_visibility}  Click Element  css=section[data-id='popupHelloModal'] span[data-id='actClose']


Switch To PMFrame
    Sleep  4s
    Unselect Frame
    Wait Until Element Is Visible  id=tenders  ${COMMONWAIT}
    Switch To Frame  id=tenders


Switch To Frame
    [Arguments]  ${frameId}
    Wait Until Element Is enabled  ${frameId}  ${COMMONWAIT}
    Select Frame  ${frameId}


Login
    [Arguments]  ${username}
    Wait Visibility And Click Element  css=a[data-target='#login_modal']
    Wait Until Element Is Visible  id=p24__login__field  ${COMMONWAIT}
    Execute Javascript  $('#p24__login__field').val('+${USERS.users['${username}'].login}')
    Input Text  xpath=//div[@id="login_modal" and @style='display: block;']//input[@type='password']  ${USERS.users['${username}'].password}
    Wait Visibility And Click Element  xpath=//div[@id="login_modal" and @style='display: block;']//button[@type='submit']
    Wait Until Element Is Visible  css=ul.user-menu  timeout=30


Wait Visibility And Click Element
    [Arguments]  ${elementLocator}
    Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
    Click Element  ${elementLocator}


Wait Element Visibility And Input Text
    [Arguments]  ${elementLocator}  ${input}
    Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
    Input Text  ${elementLocator}  ${input}


Wait For Tender
    [Arguments]  ${tender_id}  ${education_type}
    Wait Until Keyword Succeeds  10min  5s  Try Search Tender  ${tender_id}  ${education_type}


Try Search Tender
    [Arguments]  ${tender_id}  ${education_type}
    Switch To PMFrame
    Check Current Mode New Realisation

    #заполним поле поиска
    Clear Element Text  ${locator_tenderSearch.searchInput}
    Sleep  1s
    Input Text  ${locator_tenderSearch.searchInput}  ${tender_id}

    #выполним поиск
    Click Element  css=button#search-query-button
    Wait Until Element Is Not Visible  xpath=//div[@class='ajax_overflow']  ${COMMONWAIT}
    Wait Until Element Is Enabled  id=${tender_id}  timeout=10
    [Return]  True


Check Current Mode New Realisation
    [Arguments]  ${education_type}=${True}
    privatmarket.Оновити сторінку з тендером

    #проверим правильный ли режим
    Wait Until Element Is Visible  ${locator_tender.switchToDemo}  ${COMMONWAIT}
    ${check_result}=  Get Text  ${locator_tender.switchToDemo}
    Run Keyword If  '${check_result}' == 'Увійти в демо-режим' or '${check_result}' == 'Войти в демо-режим'  Switch To Education Mode


Switch To Education Mode
    [Arguments]  ${education_type}=${True}
    Wait Visibility And Click Element  ${locator_tender.switchToDemo}
    Wait Until Element Is Visible  ${locator_tender.switchToDemoMessage}  ${COMMONWAIT}


Convert Amount To Number
    [Arguments]  ${field_name}
    ${temp_name}=  Remove String  ${field_name}  '

    ${element}=  Set Variable If
        ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${field_name}
        ...  ${tender_data_${field_name}}

    ${result_full}=  Get Text  ${element}
    ${text}=  Strip String  ${result_full}
    ${text_new}=  Replace String  ${text}  ${SPACE}  ${EMPTY}
    ${result}=  convert to number  ${text_new}
    [Return]  ${result}


Wait For Element With Reload
    [Arguments]  ${locator}  ${tab_number}
    Wait Until Keyword Succeeds  5min  10s  Try Search Element  ${locator}  ${tab_number}


Try Search Element
    [Arguments]  ${locator}  ${tab_number}
    Reload And Switch To Tab  ${tab_number}
    Run Keyword If  '${tab_number}' == '1'  Відкрити детальну інформацию по позиціям
        ...  ELSE IF  'відповіді на запитання' in '${TEST_NAME}' and '${tab_number}' == '2'  Wait Visibility And Click Element  css=.question-answer .question-expand-div>a:nth-of-type(1)
    Wait Until Element Is Enabled  ${locator}  10
    [Return]  True


Reload And Switch To Tab
    [Arguments]  ${tab_number}
    Reload Page
    Switch To PMFrame
    Switch To Tab  ${tab_number}


Switch To Tab
    [Arguments]  ${tab_number}
    ${class}=  Get Element Attribute  xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]@class
    Run Keyword Unless  'white-icon' in '${class}'  Wait Visibility And Click Element  xpath=(//ul[@class='widget-header-block']//a)[${tab_number}]


Search By Query
    [Arguments]  ${element}  ${query}
    Wait Element Visibility And Input Text  ${element}  ${query}
    Wait Until Element Is Not Visible  css=.modal-body.tree.pm-tree
    Wait Until Element Is Enabled  xpath=//div[@data-id='foundItem']//label[@for='found_${query}']
    Wait Visibility And Click Element  xpath=//div[@data-id='foundItem']//label[@for='found_${query}']


Set Date And Time
    [Arguments]  ${element}  ${fild}  ${time_element}  ${date}
    Set Date  ${element}  ${fild}  ${date}
    Set Time  ${time_element}  ${date}


Set Date
    [Arguments]  ${element}  ${fild}  ${date}
    Execute Javascript  var s = angular.element('[ng-controller=CreateProcurementCtrl]').scope(); s.model.ptr.${element}.${fild} = new Date(Date.parse("${date}")); s.model.prepareDateModel(s.model.ptr, '${element}'); s.$root.$apply()


Set Date In Item
    [Arguments]  ${index}  ${element}  ${fild}  ${date}
    Execute Javascript  var s = angular.element('[ng-controller=CreateProcurementCtrl]').scope(); s.model.ptr.items[${index}].${element}.${fild} = new Date(Date.parse("${date}")); s.model.prepareDateModel(s.model.ptr.items[${index}], '${element}'); s.$root.$apply()


Set Time
    [Arguments]  ${element}  ${date}
    ${time}=  Get Regexp Matches  ${date}  T(\\d{2}:\\d{2})  1
    Input Text  ${element}  ${time[0]}


Close Confirmation In Editor
    [Arguments]  ${confirmation_text}
    Wait Until Element Is Visible  css=div.modal-body.info-div  ${COMMONWAIT}
    Wait Until Element Contains  css=div.modal-body.info-div  ${confirmation_text}  ${COMMONWAIT}
    Sleep  2s
    Wait Visibility And Click Element  css=button[ng-click='close()']
    Wait Until Element Is Not Visible  css=div.modal-body.info-div  ${COMMONWAIT}


Wait For Notification
    [Arguments]  ${message_text}
    Wait Until Element Is Enabled  xpath=//div[@class='alert-info ng-scope ng-binding']  timeout=${COMMONWAIT}
    Wait Until Element Contains  xpath=//div[@class='alert-info ng-scope ng-binding']  ${message_text}  timeout=10
