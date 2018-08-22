*** Settings ***
Library  String
Library  Selenium2Library
Library  privatmarket_service.py
Library  Collections
Library  BuiltIn

*** Variables ***
${COMMONWAIT}  12

${tender_data_assetID}  xpath=//div[@tid='assetID']
${tender_data_title}  xpath=//div[@tid='data.title']
${tender_data_description}  xpath=//div[@tid='description']
${tender_data_date}  xpath=//div[@tid='creationDate']
${tender_data_dateModified}  xpath=//div[@tid='modifyDate']
${tender_data_rectificationPeriod.endDate}  xpath=(//div[contains(@class, 'timeleft')])[1]
${tender_data_documents[0].documentType}  xpath=//span[@tid='data.informationDetailstitle']/ancestor::div[1]

${lot_data_lotID}  xpath=//div[@tid='lotID']
${lot_data_date}  xpath=//div[@tid='date']
${lot_data_dateModified}  xpath=//div[@tid='modifyDate']
${lot_data_title}  xpath=//div[@tid='data.title']
${lot_data_rectificationPeriod.endDate}  xpath=//div[@tid='data.rectificationPeriod.endDate']
${lot_data_description}  xpath=//div[@tid='description']

${lot_data_decisions[0].decisionID}  xpath=//div[@tid='decision.0.decisionID']
${lot_data_decisions[0].decisionDate}  xpath=//div[@tid='decision.0.decisionDate']
${lot_data_decisions[1].title}  xpath=//div[@tid='decision.1.title']
${lot_data_decisions[1].decisionDate}  xpath=//div[@tid='decision.1.decisionDate']
${lot_data_decisions[1].decisionID}  xpath=//div[@tid='decision.1.decisionID']

${lot_data_assets}  xpath=//div[@tid='asset']



${lot_data_auctions[0].auctionID}  css=div[tid='auction.0.auctionID']
${procedure_data_cancellations[0].reason}  css=div[tid='cancellations.reason']
${procedure_data_cancellations[0].status}  xpath=//span[@tid='data.statusName']/span[1]
${procedure_data_auctionID}  xpath=//div[@tid='data.auctionID']
${procedure_data_title}  xpath=//div[@tid='data.title']/b
${procedure_data_description}  xpath=//div[@tid='data.description']
${procedure_data_minNumberOfQualifiedBids}  xpath=//div[@tid='data.minNumberOfQualifiedBids']
${procedure_data_procurementMethodType}  xpath=//div[@tid='data.procurementMethodType']
${procedure_data_procuringEntity.name}  xpath=//div[@tid='data.procuringEntity.name']
${procedure_data_value.amount}  xpath=//span[@tid='data.value.amount']
${procedure_data_minimalStep.amount}  xpath=//span[@tid='data.minimalStep.amount']
${procedure_data_guarantee.amount}  xpath=//span[@tid='data.guarantee.amount']
${procedure_data_registrationFee.amount}  xpath=//span[@tid='data.registrationFee.amount']
${procedure_data_tenderPeriod.endDate}  xpath=//div[@tid='data.enquiryPeriod']//span[@tid='period.to']
${procedure_data_auctionPeriod.startDate}  xpath=//div[@tid='data.auctionPeriod']//span[@tid='period.from']
${procedure_data_auctionPeriod.endDate}  xpath=//div[@tid='data.auctionPeriod']//span[@tid='period.to']

${procedure_data.questions[0].title}  span[@tid='data.question.title']
${procedure_data.questions[0].description}  span[@tid='data.question.description']
${procedure_data.questions[0].answer}  span[@tid='data.question.answer']

${procedure_data_awards[0].status}  xpath=(//span[@tid='award.status'])[1]


${lot_data_lotHolder.name}  xpath=//div[@tid='lotHolder.name']
${lot_data_lotHolder.identifier.scheme}  xpath=//div[@tid='lotHolder.identifier.scheme']
${lot_data_lotHolder.identifier.id}  xpath=//div[@tid='lotHolder.identifier.id']

${lot_data_lotCustodian.identifier.scheme}  xpath=//div[@tid='data.assetCustodian.identifier.scheme']
${lot_data_lotCustodian.identifier.id}  xpath=//div[@tid='data.assetCustodian.identifier.id']
${lot_data_lotCustodian.identifier.legalName}  xpath=//div[@tid='data.assetCustodian.identifier.legalName']
${lot_data_lotCustodian.contactPoint.name}  xpath=//div[@tid='data.lotCustodian.contactPoint.name']
${lot_data_lotCustodian.contactPoint.telephone}  xpath=//div[@tid='data.lotCustodian.contactPoint.telephone']
${lot_data_lotCustodian.contactPoint.email}  xpath=//div[@tid='data.lotCustodian.contactPoint.email']

${tender_data_decisions[0].title}  xpath=//div[@tid='decision.title']
${tender_data_decisions[0].decisionDate}  xpath=//div[@tid='decision.date']
${tender_data_decisions[0].decisionID}  xpath=//div[@tid='decision.id']

${tender_data_assetHolder.name}  xpath=//div[@tid='assetHolder.name']
${tender_data_assetHolder.identifier.id}  xpath=//div[@tid='assetHolder.identifier.id']
${tender_data_assetHolder.identifier.scheme}  xpath=//div[@tid='assetHolder.identifier.scheme']

${tender_data_assetCustodian.contactPoint.name}  xpath=//div[@tid='data.assetCustodian.contactPoint.name']
${tender_data_assetCustodian.contactPoint.telephone}  xpath=//div[@tid='data.assetCustodian.contactPoint.telephone']
${tender_data_assetCustodian.contactPoint.email}  xpath=//div[@tid='data.assetCustodian.contactPoint.email']
${tender_data_assetCustodian.identifier.scheme}  xpath=//div[@tid='data.assetCustodian.identifier.scheme']
${tender_data_assetCustodian.identifier.id}  xpath=//div[@tid='data.assetCustodian.identifier.id']
${tender_data_assetCustodian.identifier.legalName}  xpath=//div[@tid='data.assetCustodian.identifier.legalName']

${tender_data.assets.description}  div[@tid="item.description"]
${tender_data.assets.classification.scheme}  span[@tid="item.classification.scheme"]
${tender_data.assets.classification.id}  span[@tid="item.classification.id"]
${tender_data.assets.unit.name}  span[@tid="item.unit.name"]
${tender_data.assets.quantity}  span[@tid="item.quantity"]
${tender_data.assets.registrationDetails.status}  div[@tid="item.registrationDetails.status"]


*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  ${username}
  [Documentation]  Відкрити брaузер, створити обєкт api wrapper, тощо
  ${disabled}  Create List  Chrome PDF Viewer
  ${prefs}  Create Dictionary  download.default_directory=${OUTPUT_DIR}  plugins.plugins_disabled=${disabled}

  ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
  Call Method  ${options}  add_argument  --allow-running-insecure-content
  Call Method  ${options}  add_argument  --disable-web-security
  Call Method  ${options}  add_argument  --nativeEvents\=false
  Call Method  ${options}  add_experimental_option  prefs  ${prefs}

  ${alias}=   Catenate   SEPARATOR=   browser  ${username}
  Set Global Variable  ${ALIAS_NAME}  ${alias}
  Run Keyword  Create WebDriver  Chrome  chrome_options=${options}  alias=${ALIAS_NAME}

  Set Window Size  @{USERS.users['${username}'].size}
  Set Window Position  @{USERS.users['${username}'].position}
  Go To  ${USERS.users['${username}'].homepage}
  Run Keyword Unless  'Viewer' in '${username}'  Login  ${username}


Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  Run Keyword If  '${role_name}' != 'tender_owner'  Return From Keyword  ${tender_data}
  ${tender_data}=  modify_test_data  ${tender_data}
  [Return]  ${tender_data}


Створити об'єкт МП
  [Arguments]  ${user_name}  ${tender_data}
  ${decisions}=  Get From Dictionary  ${tender_data.data}  decisions
  ${decisions_number}=  Get Length  ${decisions}
  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${items_number}=  Get Length  ${items}

  Wait Enable And Click Element  css=#simple-dropdown
  Wait Enable And Click Element  css=a[href='#/add-asset']
  Wait Until Element Is Visible  css=input[tid="asset.title"]  ${COMMONWAIT}

  Input text  css=input[tid="asset.title"]  ${tender_data.data.title}
  Input text  css=input[tid="asset.title_ru"]  ${tender_data.data.title_ru}
  Input text  css=input[tid="asset.title_en"]  ${tender_data.data.title_en}

  Input text  css=textarea[tid="asset.description"]  ${tender_data.data.description}
  Input text  css=textarea[tid="asset.description_ru"]  ${tender_data.data.description_ru}
  Input text  css=textarea[tid="asset.description_en"]  ${tender_data.data.description_en}

  :FOR  ${index}  IN RANGE  ${decisions_number}
  \  ${should_we_click_btn_add_decision}=  Set Variable If  '0' != '${index}'  ${True}  ${False}
  \  Додати рішення  ${decisions[${index}]}  ${should_we_click_btn_add_decision}


  Wait Enable And Click Element  css=a[ng-click="assetHolder = !assetHolder"]
  Wait Until Element Is Enabled  css=input[tid="assetHolder.identifier.id"]  ${COMMONWAIT}
  Input text  css=input[tid="assetHolder.identifier.id"]  ${tender_data.data.assetHolder.identifier.id}
  Input text  css=input[tid="assetHolder.identifier.legalName"]  ${tender_data.data.assetHolder.identifier.legalName}
  Input text  css=input[tid="assetHolder.address.street"]  ${tender_data.data.assetHolder.address.streetAddress}
  Input text  css=input[tid="assetHolder.address.locality"]  ${tender_data.data.assetHolder.address.locality}
  Input text  css=input[tid="assetHolder.address.region"]  ${tender_data.data.assetHolder.address.region}
  Input text  css=input[tid="assetHolder.address.postalCode"]  ${tender_data.data.assetHolder.address.postalCode}
  Input text  css=input[tid="assetHolder.address.country"]  ${tender_data.data.assetHolder.address.countryName}
  Input text  css=input[tid="assetHolder.contacts.name"]  ${tender_data.data.assetHolder.contactPoint.name}
  Input text  css=input[tid="assetHolder.contacts.email"]  ${tender_data.data.assetHolder.contactPoint.email}
  Input text  css=input[tid="assetHolder.contacts.phone"]  ${tender_data.data.assetHolder.contactPoint.telephone}
  Input text  css=input[tid="assetHolder.contacts.fax"]  ${tender_data.data.assetHolder.contactPoint.faxNumber}
  Input text  css=input[tid="assetHolder.contacts.url"]  ${tender_data.data.assetHolder.contactPoint.url}

  :FOR  ${index}  IN RANGE  ${items_number}
  \  ${should_we_click_btn_add_item}=  Set Variable If  '0' != '${index}'  ${True}  ${False}
  \  Додати об'єкт продажу  ${items[${index}]}  ${should_we_click_btn_add_item}

  Click Button  css=button[tid="btn.createasset"]
  Wait For Ajax
  Wait Until Element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}
  Wait For Ajax
  Wait Enable And Click Element  css=button[tid="btn.publicateLot"]
  Wait For Ajax
  Wait For Element With Reload  xpath=//div[contains(@tid, 'assetID') and contains(., 'UA-')]
  ${tender_id}=  Get Text  css=div[tid='assetID']
  Go To  ${USERS.users['${username}'].homepage}
  Wait For Ajax
  Log To Console  ${tender_id}
  [Return]  ${tender_id}


Створити лот
  [Arguments]  ${user_name}  ${tender_data}  ${asset_id}
  ${decisions_date}=  Get From Dictionary  ${tender_data.data.decisions[0]}  decisionDate
  ${decisions_id}=  Get From Dictionary  ${tender_data.data.decisions[0]}  decisionID
  privatmarket.Пошук об’єкта МП по ідентифікатору  ${user_name}  ${asset_id}
  Wait Enable And Click Element  css=button[tid='btn.createInfo']
  ${correctDate}=  Convert Date  ${decisions_date}  result_format=%d/%m/%Y
  ${correctDate}=  Convert To String  ${correctDate}
  Input text  xpath=//input[@tid='decision.date']  ${correctDate}
  Wait Until Element Is Enabled  xpath=//input[@tid='decision.id']  ${COMMONWAIT}
  Input text  xpath=//input[@tid='decision.id']  ${decisions_id}
  ${scenarios_name}=  get_scenarios_name
  ${accelerator}=  get_accelerator  ${scenarios_name}
  Execute Javascript  angular.prozorroaccelerator=${accelerator};
  Execute Javascript  angular.prozorroauctionstartdelay = (30+180)*60*1000;
  Click Element  xpath=//button[@tid='btn.createaInfo']
  Wait For Ajax
  Execute Javascript  document.querySelector("span[tid='lotID']").className = ''
  sleep  2
  ${tender_id}=  Get Element Attribute  xpath=//span[@tid='lotID']@data-id
  Log To Console  ${tender_id}
  [Return]  ${tender_id}


Активувати процедуру
  [Arguments]  ${username}  ${tender_id}
  Log To Console  ${tender_id}
  Wait For Ajax
  privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_id}
  Wait Until Keyword Succeeds  10min  15s  Дочекатися активованого статусу процедури


Дочекатися активованого статусу процедури
  ${status}=  Get Element Attribute  xpath=//span[@tid='data.status']@data-status
  ${current_status}=  Strip String  ${status}
  Should Be Equal  ${current_status}  active.tendering  msg=The procedure is not active


Додати умови проведення аукціону
  [Arguments]  ${username}  ${tender_data}  ${index}  ${tender_id}
  Run Keyword If  '${index}' == '0'
  ...  Заповнити дані про аукціон  ${tender_data}
  ...  ELSE  Заповнити тривалість аукціону  ${tender_data}


Заповнити дані про аукціон
  [Arguments]  ${tender_data}
  ${date}=  Get From Dictionary  ${tender_data.auctionPeriod}  startDate
  ${correctDate}=  increase_date_on_days  ${date}  5
  ${value}=  Convert To String  ${tender_data.value.amount}
  ${guarantee}=  Convert To String  ${tender_data.guarantee.amount}
  ${minimalStep}=  Convert To String  ${tender_data.minimalStep.amount}
  ${registrationFee}=  Convert To String  ${tender_data.registrationFee.amount}
  Wait Enable And Click Element  css=input[tid='valueAddedTaxIncluded']
  Wait Until Element Is Visible  css=input[tid='auction.value']  ${COMMONWAIT}
  Input Text  css=input[tid='auction.value']  ${value}
  Input Text  css=input[tid='auction.guarantee']  ${guarantee}
  Input Text  css=input[tid='auction.minimalStep']  ${minimalStep}
  Input Text  css=input[tid='auction.period']  ${correctDate}
  Input Text  css=input[tid='auction.registrationFee']  ${registrationFee}
  Input Text  css=input[tid='auction.bankAccount.description']  ${tender_data.bankAccount.description}
  Input Text  css=input[tid='auction.bankAccount.bankName']  ${tender_data.bankAccount.bankName}
  Input Text  css=input[tid='auction.bankAccount.accountIdentification.mfo']  ${tender_data.bankAccount.accountIdentification[0].scheme}
  Input Text  css=input[tid='auction.bankAccount.accountIdentification.crf']  ${tender_data.bankAccount.accountIdentification[0].id}


Заповнити тривалість аукціону
  [Arguments]  ${tender_data}
  ${duration}=  Get From Dictionary  ${tender_data}  tenderingDuration
  ${count}=  Set Variable If  '${duration}' == 'P1M'  30
  Input Text  xpath=//input[@tid='auction.tenderingDuration']  ${count}
  Click Element  xpath=//button[@tid='btn.createInfo']
  Wait For Ajax
  Wait Until Element Is Visible  ${lot_data_title}  ${COMMONWAIT}


Додати рішення
  [Arguments]  ${decision}  ${should_we_click_btn_add_decision}=${False}
  Run Keyword If  ${should_we_click_btn_add_decision}  Wait Visibulity And Click Element  css=button[tid="btn.adddecision"]
  Sleep  1s
  Input text  xpath=(//input[@tid="decision.title"])[last()]  ${decision.title}
  Input text  xpath=(//input[@tid="decision.title_ru"])[last()]  ${decision.title_ru}
  Input text  xpath=(//input[@tid="decision.title_en"])[last()]  ${decision.title_en}

  ${correctDate}=  Convert Date  ${decision.decisionDate}  result_format=%d/%m/%Y
  ${correctDate}=  Convert To String  ${correctDate}

  Input text  xpath=(//input[@tid="decision.date"])[last()]  ${correctDate}
  Input text  xpath=(//input[@tid="decision.id"])[last()]  ${decision.decisionID}


Додати об'єкт продажу
  [Arguments]  ${item}  ${should_we_click_btn_add_item}=${False}
  Run Keyword If  ${should_we_click_btn_add_item}  Wait Visibulity And Click Element  css=button[tid="btn.additem"]
  Sleep  1s
  Input text  xpath=(//textarea[@tid="item.description"])[last()]  ${item.description}
  #classification
  Input text  xpath=(//div[@tid='classification']//input)[last()]  ${item.classification.id}
  Wait Until Element Is Enabled  xpath=(//ul[contains(@class, 'ui-select-choices-content')])[last()]
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${item.classification.id}')]
  #quantity
  ${quantity}=  Convert To String  ${item.quantity}
  Input text  xpath=(//input[@tid='item.quantity'])[last()]  ${quantity}
  Select From List  xpath=(//select[@tid='item.unit.name'])[last()]  ${item.unit.name}
  Sleep  1s
  Select From List  xpath=(//select[@tid='registrationDetails.status'])[last()]  string:${item.registrationDetails.status}

  #address
  Select Checkbox  xpath=(//input[@tid='item.address.checkbox'])[last()]
  Input text  xpath=(//input[@tid='item.address.countryName'])[last()]  ${item.address.countryName}
  Input text  xpath=(//input[@tid='item.address.postalCode'])[last()]  ${item.address.postalCode}
  Input text  xpath=(//input[@tid='item.address.region'])[last()]  ${item.address.region}
  Input text  xpath=(//input[@tid='item.address.streetAddress'])[last()]  ${item.address.streetAddress}
  Input text  xpath=(//input[@tid='item.address.locality'])[last()]  ${item.address.locality}


Оновити сторінку з об'єктом МП
  [Arguments]  ${user_name}  ${tender_id}
  Switch Browser  ${ALIAS_NAME}
  ${tenderEdit}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=input[tid='data.title']  5s
  Run Keyword If  '${tenderEdit}' == 'False'  Reload Page
  Sleep  3s


Оновити сторінку з лотом
  [Arguments]  ${user_name}  ${tender_id}
  privatmarket.Оновити сторінку з об'єктом МП  ${user_name}  ${tender_id}


Оновити сторінку з тендером
  [Arguments]  ${user_name}  ${tender_id}
  privatmarket.Оновити сторінку з об'єктом МП  ${user_name}  ${tender_id}


Пошук об’єкта МП по ідентифікатору
  [Arguments]  ${user_name}  ${tender_id}
  Wait For Auction  ${tender_id}
  Wait For Ajax
  Wait Enable And Click Element  css=div[tid='${tender_id}']
  Wait Until element Is Visible  css=div[tid='data.title']  ${COMMONWAIT}


Пошук лоту по ідентифікатору
  [Arguments]  ${user_name}  ${tender_id}
  privatmarket.Пошук об’єкта МП по ідентифікатору  ${user_name}  ${tender_id}


Пошук тендера по ідентифікатору
  [Arguments]  ${user_name}  ${tender_id}
  privatmarket.Пошук об’єкта МП по ідентифікатору  ${user_name}  ${tender_id}


Отримати інформацію з активу об'єкта МП
  [Arguments]  ${username}  ${tender_id}  ${object_id}  ${field_name}
  ${element}=  Convert To String  assets.${field_name}
  ${element_for_work}=  Set variable  xpath=//div[@ng-repeat='item in data.items' and contains(., '${object_id}')]//${tender_data.${element}}
  Wait For Element With Reload  ${element_for_work}

  Run Keyword And Return If  '${field_name}' == 'quantity'  Отримати число  ${element_for_work}
  Run Keyword And Return If  '${field_name}' == 'registrationDetails.status'  Отримати registrationDetails.status  ${element_for_work}

  Wait Until Element Is Visible  ${element_for_work}  timeout=${COMMONWAIT}
  ${result}=  Отримати текст елемента  ${element_for_work}
  [Return]  ${result}


Отримати інформацію з рішення
  [Arguments]  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'decisions[0].decisionID'  Get Text  ${lot_data_decisions[0].decisionID}
  Run Keyword And Return If  '${field_name}' == 'decisions[1].title'  Get Text  ${lot_data_decisions[1].title}
  Run Keyword And Return If  '${field_name}' == 'decisions[1].decisionID'  Get Text  ${lot_data_decisions[1].decisionID}
  Run Keyword And Return If  'decisionDate' in '${field_name}'  Отримати дату з рішення  ${field_name}


Отримати інформацію з активу лоту
  [Arguments]  ${username}  ${tender_id}  ${object_id}  ${field_name}
  ${result}=  privatmarket.Отримати інформацію з активу об'єкта МП  ${username}  ${tender_id}  ${object_id}  ${field_name}
  [Return]  ${result}


Отримати інформацію із об'єкта МП
  [Arguments]  ${user_name}  ${tender_id}  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'status'  Отримати status об'єкту МП  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'decisions[0].decisionDate'  Отримати дату  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'dateModified'  Отримати дату внесення змін  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'date'  Отримати creationDate   ${field_name}
  Run Keyword And Return If  '${field_name}' == 'rectificationPeriod.endDate'  Отримати rectificationPeriod.endDate  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'documents[0].documentType'  Отримати documents[0].documentType  ${field_name}

  Wait Until Element Is Visible  ${tender_data_${field_name}}
  ${result_full}=  Get Text  ${tender_data_${field_name}}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати інформацію із лоту
  [Arguments]  ${user_name}  ${tender_id}  ${field_name}
  ${status}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=.glyphicon-plus-sign  1s
  Run Keyword If  ${status}  Click Element  css=.glyphicon-plus-sign

  Run Keyword And Return If  '${field_name}' == 'status'  Отримати status лоту  ${field_name}
  Run Keyword And Return If  'procurementMethodType' in '${field_name}'  Отримати тип аукціону  ${field_name}
  Run Keyword And Return If  'status' in '${field_name}' and 'auction' in '${field_name}'  Отримати статус аукціону  ${field_name}
  Run Keyword And Return If  'tenderAttempts' in '${field_name}'  Отримати кількість виставлень лоту  ${field_name}
  Run Keyword And Return If  'value.amount' in '${field_name}'  Отримати початкову вартість аукціону  ${field_name}
  Run Keyword And Return If  'minimalStep.amount' in '${field_name}'  Отримати крок аукціону  ${field_name}
  Run Keyword And Return If  'guarantee.amount' in '${field_name}'  Отримати розмір гарантійного внеску аукціону  ${field_name}
  Run Keyword And Return If  'registrationFee.amount' in '${field_name}'  Отримати розмір реєстраційного внеску аукціону  ${field_name}
  Run Keyword And Return If  'tenderingDuration' in '${field_name}'  Отримати період на подачу пропозицій  ${field_name}
  Run Keyword And Return If  'auctionPeriod.startDate' in '${field_name}'  Отримати дату початку аукціону  ${field_name}
  Run Keyword And Return If  'decisions' in '${field_name}'  Отримати інформацію з рішення  ${field_name}
  Run Keyword And Return If  'date' in '${field_name}'  Отримати lot_dates  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'rectificationPeriod.endDate'  Отримати lot_dates  ${field_name}

  Wait Until Element Is Visible  ${lot_data_${field_name}}
  ${result_full}=  Get Text  ${lot_data_${field_name}}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати інформацію із тендера
  [Arguments]  ${user_name}  ${tender_id}  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'status'  Отримати status аукціону  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'procurementMethodType'  Get Element Attribute  ${procedure_data_${field_name}}@tidvalue
  Run Keyword And Return If  '${field_name}' == 'cancellations[0].status'  Get Cancellation Status  ${procedure_data_${field_name}}  # ЗАГЛУШКА (ЧТО ЗА СТАТУС ???)
  Run Keyword And Return IF  '.amount' in '${field_name}' or '${field_name}' == 'minNumberOfQualifiedBids'  Отримати число  ${procedure_data_${field_name}}
  Run Keyword And Return IF  '${field_name}' == 'tenderPeriod.endDate'  Отримати дату та час  ${procedure_data_${field_name}}
  Run Keyword And Return IF  '${field_name}' == 'auctionPeriod.startDate'  Отримати дату та час  ${procedure_data_${field_name}}
  Run Keyword And Return IF  '${field_name}' == 'auctionPeriod.endDate'  Отримати дату та час  ${procedure_data_${field_name}}
  Run Keyword And Return If  '${field_name}' == 'awards[0].status'  Отримати awards status  ${field_name}
  Run Keyword And Return If  '${field_name}' == 'awards[1].status'  Отримати awards status  ${field_name}

  Wait Until Element Is Visible  ${procedure_data_${field_name}}
  ${result_full}=  Get Text  ${procedure_data_${field_name}}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_id}  ${object_id}  ${field_name}
  ${result}=  privatmarket.Отримати інформацію з активу об'єкта МП  ${username}  ${tender_id}  ${object_id}  ${field_name}
  [Return]  ${result}


Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_id}  ${doc_id}  ${element}
  ${result}=  Run Keyword If  'скасування процедури' in '${TEST_NAME}'  Get Text  css=div[tid='cancellations.doc'] div[tid='doc.title']

  ${result}=  Strip String  ${result}
  [Return]  ${result}


Задати запитання на тендер
  [Arguments]  ${user_name}  ${tender_id}  ${question_data}
  Wait Until Element Is Visible  css=input[ng-model='newQuestion.title']  ${COMMONWAIT}
  Input Text  css=input[ng-model='newQuestion.title']  ${question_data.data.title}
  Input Text  css=textarea[ng-model='newQuestion.text']  ${question_data.data.description}

  Click Element  css=div[ng-model='newQuestion.questionOf'] span
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., 'Загальне запитання')]

  Click Button  css=button[tid='sendQuestion']
  Sleep  5s
  Wait For Element With Reload  css=span[tid='data.question.date']


Задати запитання на предмет
  [Arguments]  ${user_name}  ${tender_id}  ${item_id}  ${question_data}
  Wait Until Element Is Visible  css=input[ng-model='newQuestion.title']  ${COMMONWAIT}
  Input Text  css=input[ng-model='newQuestion.title']  ${question_data.data.title}
  Input Text  css=textarea[ng-model='newQuestion.text']  ${question_data.data.description}

  Click Element  css=div[ng-model='newQuestion.questionOf'] span
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${item_id}')]

  Click Button  css=button[tid='sendQuestion']
  Sleep  5s
  Wait Until Keyword Succeeds  3min  3s  Check If Question Is Uploaded  ${question_data.data.title}


Check If Question Is Uploaded
  [Arguments]  ${title}
  Reload Page
  Wait For Ajax
  @{subtitle}=  Split String  ${title}  '
  Wait Until Element Is Enabled  xpath=//div[@ng-repeat='question in data.questions']//span[@tid='data.question.title' and contains(., '${subtitle[0]}')]  3
  [Return]  True


Відповісти на запитання
  [Arguments]  ${user_name}  ${tender_id}  ${answer}  ${question_id}
  Wait Until Element Is Visible  xpath=//div[@class='row question' and contains(., '${question_id}')]//button[@tid='answerQuestion']  ${COMMONWAIT}
  Wait Until Element Is Visible  xpath=//div[@class='row question' and contains(., '${question_id}')]//input[@tid='input.answer']  ${COMMONWAIT}
  Input Text  xpath=//div[@class='row question' and contains(., '${question_id}')]//input[@tid='input.answer']  ${answer.data.answer}
  Click Button  xpath=//div[@class='row question' and contains(., '${question_id}')]//button[@tid='answerQuestion']
  Sleep  3s
  Wait For Ajax


Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_id}  ${questions_id}  ${element}
  ${element}=  Convert To String  questions[0].${element}
  ${element_for_work}=  Set variable  xpath=//div[contains(@class, 'questionsBox') and contains(., '${questions_id}')]//${procedure_data.${element}}
  Wait Until Element Is Visible  ${element_for_work}  ${COMMONWAIT}
  ${result}=  Отримати текст елемента  ${element_for_work}
  [Return]  ${result}


Отримати тип аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Get Element Attribute  xpath=//div[@tid="auction.${index[0]}.procurementMethod"]@tidvalue
  [Return]  ${result}


Отримати статус аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Get Element Attribute  xpath=//div[@tid="auction.${index[0]}.status"]@tidvalue
  [Return]  ${result}


Отримати кількість виставлень лоту
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Отримати текст елемента  xpath=//div[@tid="auction.${index[0]}.tenderAttempts"]
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Отримати початкову вартість аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Отримати текст елемента  xpath=//span[@tid="auction.${index[0]}.value.amount"]
  ${result}=  Remove String  ${result}  ${SPACE}
  ${result}=  Replace String  ${result}  ,  .
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Отримати крок аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Отримати текст елемента  xpath=//span[@tid="auction.${index[0]}.minimalStep.amount"]
  ${result}=  Remove String  ${result}  ${SPACE}
  ${result}=  Replace String  ${result}  ,  .
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Отримати розмір гарантійного внеску аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Отримати текст елемента  xpath=//span[@tid="auction.${index[0]}.guarantee.amount"]
  ${result}=  Remove String  ${result}  ${SPACE}
  ${result}=  Replace String  ${result}  ,  .
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Отримати розмір реєстраційного внеску аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Отримати текст елемента  xpath=//span[@tid="auction.${index[0]}.registrationFee.amount"]
  ${result}=  Remove String  ${result}  ${SPACE}
  ${result}=  Replace String  ${result}  ,  .
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Отримати період на подачу пропозицій
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Get Element Attribute  xpath=//div[@tid="auction.${index[0]}.tenderingDuration"]@tidvalue
  [Return]  ${result}


Отримати дату початку аукціону
  [Arguments]  ${field_name}
  ${index}=  Get Regexp Matches  ${field_name}  [(\\d)]  0
  ${result}=  Get Element Attribute  xpath=//div[@tid="auction.${index[0]}.auctionPeriod.startDate"]@tidvalue
  [Return]  ${result}


Подати цінову пропозицію
  [Arguments]  ${user_name}  ${tender_id}  ${bid}
  Switch Browser  ${ALIAS_NAME}
  ${os}=  Evaluate  platform.system()  platform
  Run Keyword If  'без кваліфікації' in '${TEST NAME}'  Fail  Is not implemented yet
  #дождаться появления поля ввода ссуммы только в случае выполнения первого позитивного теста
  Run Keyword Unless  'Неможливість подати цінову' in '${TEST NAME}' or 'подати повторно цінову' in '${TEST NAME}'
  ...  Wait Until Element Is Enabled  css=button[tid='createBid']  ${COMMONWAIT}
  Click Button  css=button[tid='createBid']
  Wait Until Element Is Enabled  css=#amount  ${COMMONWAIT}
  Run Keyword Unless  '${MODE}' == 'dgfInsider'  Вказати ціну і підтвердити подання пропозиції  ${bid}  ${os}


Вказати ціну і підтвердити подання пропозиції
  [Arguments]  ${bid}  ${os}
  ${amount}=  Convert To String  ${bid.data.value.amount}
  ${amount2}=  Replace String  ${amount}  .  ,
  Run Keyword If  '${os}' == 'Linux'  Input Text  css=input[tid='bid.value.amount']  ${amount}
  ...  ELSE  Input Text  css=input[tid='bid.value.amount']  ${amount2}
  Click Button  css=div#bid button[tid='createBid']
  Wait For Ajax
  Wait Visibility And Click Element  css=button[tid='saveAndConfirm']
  Wait For Ajax
  Wait Until Page Contains  Ставка успішно збережена  60
  Click Element  xpath=//button[@tid='defaultOk']


Отримати інформацію із пропозиції
  [Arguments]  ${user_name}  ${tender_id}  ${field}
  ${locator}=  Set Variable If  '${field}' == 'value.amount'  css=span[tid='bid.amount']  null
  Wait For Ajax
  Wait For Element With Reload  ${locator}
  ${result}=  Get Text  ${locator}
  ${result}=  Replace String  ${result}  ${SPACE}  ${EMPTY}
  ${result}=  Replace String  ${result}  ,  .
  ${result}=  Convert To Number  ${result}
  [Return]  ${result}


Змінити цінову пропозицію
  [Arguments]  ${user_name}  ${tender_id}  ${name}  ${value}
  ${os}=  Evaluate  platform.system()  platform
  ${amount}=  Convert To String  ${value}
  ${amount2}=  Replace String  ${amount}  .  ,

  Wait For Element With Reload  css=button[tid='modifyBid']  5
  Wait Visibility And Click Element  css=button[tid='modifyBid']
  Wait Until Element Is Visible  css=input[tid='bid.value.amount']  ${COMMONWAIT}
  Clear Element Text  css=input[tid='bid.value.amount']
  Run Keyword If  '${os}' == 'Linux'  Input Text  css=input[tid='bid.value.amount']  ${amount}
  ...  ELSE  Input Text  css=input[tid='bid.value.amount']  ${amount2}

  Click Element  css=div#bid button[tid='createBid']
  Wait For Ajax
  Wait Visibility And Click Element  css=button[tid='saveAndConfirm']
  Wait For Ajax
  Wait Until Page Contains  Ставка успішно збережена  60
  Click Element  xpath=//button[@tid='defaultOk']


Завантажити документ в ставку
  [Arguments]  ${user_name}  ${filepath}  ${tender_id}=${None}
  Wait Visibility And Click Element  css=button[tid='modifyBid']
  Wait Until Element Is Visible  xpath=//*[@tid='btn.addProposalDocs']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='addProposalDocs']").className = ''
  Sleep  2s
  Choose File  css=input[id='addProposalDocs']  ${filepath}
  Sleep  10s
  Wait For Ajax
  Wait Visibility And Click Element  css=div#bid button[tid='createBid']
  Wait Visibility And Click Element  css=button[tid='saveAndConfirm']
  Wait Until Page Contains  Документи додані до пропозиції  60
  Wait For Ajax
  Wait Until Element Is Enabled  xpath=//button[@tid='defaultOk']  ${COMMONWAIT}
  Click Element  xpath=//button[@tid='defaultOk']


Скасувати цінову пропозицію
  [Arguments]  ${user_name}  ${tender_id}
  Wait For Element With Reload  css=button[tid='btn.deleteBid']  5
  Wait Visibility And Click Element  css=button[tid='btn.deleteBid']
  Wait For Ajax
  Wait Visibility And Click Element  css=button[tid='modal.button.1']


Внести зміни в об'єкт МП
  [Arguments]  ${user_name}  ${tender_id}  ${field_name}  ${value}
  Reload Page
  Sleep  5s
  Wait Enable And Click Element  xpath=//button[@tid='btn.modifyLot']
  Run Keyword If
    ...  '${field_name}' == 'title'  Внести зміни в поле  css=input[tid='asset.title']  ${value}
    ...  ELSE IF  '${field_name}' == 'description'  Внести зміни в поле  css=textarea[tid="asset.description"]  ${value}
    ...  ELSE IF  '${field_name}'== 'decisions[0].title'  Внести зміни в поле  xpath=(//input[@tid="decision.title"])  ${value}


Внести зміни в лот
  [Arguments]  ${user_name}  ${tender_id}  ${field_name}  ${value}
  Reload Page
  Sleep  5s
  Wait Enable And Click Element  xpath=//button[@tid='btn.modifyLot']
  Завантажити документ про зміни  ${username}  ${tender_id}
  Run Keyword If
    ...  '${field_name}' == 'title'  Внести зміни в поле  css=input[tid='lot.title']  ${value}
    ...  ELSE IF  '${field_name}' == 'description'  Внести зміни в поле  css=textarea[tid="lot.description"]  ${value}
  Wait Until Element Is Enabled  xpath=//button[@tid='btn.modifyLot']  ${COMMONWAIT}



Внести зміни в актив об'єкта МП
  [Arguments]  ${user_name}  ${item_id}  ${tender_id}  ${field_name}  ${value}
  Reload Page
  Sleep  5s
  Wait Enable And Click Element  xpath=//button[@tid='btn.modifyLot']
  ${quantity}=  Run Keyword If  '${field_name}' == 'quantity'  Convert To String  ${value}
  Run Keyword If
    ...  '${field_name}' == 'quantity'  Внести зміни в поле  xpath=(//input[@tid='item.quantity'])  ${quantity}
    ...  ELSE IF  '${field_name}' == 'description'  Внести зміни в поле  css=textarea[tid="asset.description"]  ${value}


Внести зміни в актив лоту
  [Arguments]  ${user_name}  ${item_id}  ${tender_id}  ${field_name}  ${value}
  Reload Page
  Sleep  5s
  Wait Enable And Click Element  xpath=//button[@tid='btn.modifyLot']
  ${quantity}=  Run Keyword If  '${field_name}' == 'quantity'  Convert To String  ${value}
  Run Keyword If  '${field_name}' == 'quantity'  Run Keywords
    ...  Завантажити документ про зміни  ${username}  ${tender_id}
    ...  AND  Внести зміни в поле  xpath=(//input[@tid='item.quantity'])  ${quantity}
  Wait Until Element Is Enabled  xpath=//button[@tid='btn.modifyLot']  ${COMMONWAIT}


Внести зміни в умови проведення аукціону
  [Arguments]  ${username}  ${tender_id}  ${field_name}  ${value}  ${auction_index}
  privatmarket.Пошук лоту по ідентифікатору  ${user_name}  ${tender_id}
  Reload Page
  Sleep  5s
  Wait Enable And Click Element  xpath=//button[@tid='btn.modifyLot']
  Завантажити документ про зміни  ${username}  ${tender_id}
  ${correct_value}=  Run Keyword If
    ...  'amount' in '${field_name}'  Convert To String  ${value}
    ...  ELSE IF  '${field_name}' == 'auctionPeriod.startDate'  Get New Auction Date  ${value}
  Run Keyword If
    ...  '${field_name}' == 'value.amount'  Внести зміни в поле  xpath=(//input[@tid='auction.value'])  ${correct_value}
    ...  ELSE IF  '${field_name}' == 'minimalStep.amount'  Внести зміни в поле  xpath=(//input[@tid='auction.minimalStep'])  ${correct_value}
    ...  ELSE IF  '${field_name}' == 'guarantee.amount'  Внести зміни в поле  xpath=(//input[@tid='auction.guarantee'])  ${correct_value}
    ...  ELSE IF  '${field_name}' == 'registrationFee.amount'  Внести зміни в поле  xpath=(//input[@tid='auction.registrationFee'])  ${correct_value}
    ...  ELSE IF  '${field_name}' == 'auctionPeriod.startDate'  Змінити дату аукціону  ${correct_value}
  Wait Until Element Is Enabled  xpath=//button[@tid='btn.modifyLot']  ${COMMONWAIT}


Видалити об'єкт МП
  [Arguments]  ${user_name}  ${tender_id}
  Switch Browser  ${ALIAS_NAME}
  Reload Page
  Wait Until Page Contains  Виключено з переліку  60


Видалити лот
  [Arguments]  ${user_name}  ${tender_id}
  Switch Browser  ${ALIAS_NAME}
  Reload Page
  Wait Until Page Contains  Об’єкт виключено  60


Скасувати закупівлю
  [Arguments]  ${user_name}  ${tender_id}  ${reason}  ${doc_path}  ${description}
  privatmarket.Пошук тендера по ідентифікатору  ${user_name}  ${tender_id}
  Wait Enable And Click Element  css=button[tid='btn.cancellationLot']
  Wait For Ajax
  #add doc
  Wait Until Element Is Visible  css=button[tid='docCancellation']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("#docsCancellation").className = ''
  Sleep  2s
  Choose File  css=#docsCancellation  ${doc_path}
  Wait For Ajax
  #input description
  Wait Until Element Is Enabled  css=input[tid='cancellation.description']
  Input text  css=input[tid='cancellation.description']  ${description}
  #input reason
  Input text  css=input[tid='cancellation.reason']  ${reason}
  #confirm
  Click Button  css=button[tid='btn.cancellation']
  Sleep  10s
  Wait For Ajax
  Wait Until Page Contains  Аукціон відмінено  60


Скасування рішення кваліфікаційної комісії
  [Arguments]  ${user_name}  ${tender_id}  ${award_num}
  privatmarket.Пошук тендера по ідентифікатору  ${username}  ${tender_id}
  Wait For Element With Reload  css=button[tid='btn.award.cancellation']  4
  Click Button  css=button[tid='btn.award.cancellation']
  Wait For Ajax
  Wait Until Element Is Visible  xpath=(//div[@tid='dialogModal']//button[contains(@class, 'btn btn-success')])[2]  ${COMMONWAIT}
  Click Button  xpath=(//div[@tid='dialogModal']//button[contains(@class, 'btn btn-success')])[2]
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Завантажити протокол дискваліфікації в авард
  [Arguments]  ${user_name}  ${tender_id}  ${doc_path}  ${award_num}
  Wait Visibility And Click Element  css=button[tid='btn.award.disqualify']
  Wait Until Element Is Visible  css=button[tid='btn.award.addDocForCancel']  ${COMMONWAIT}
  Click Element  xpath=//input[@tid='disqualifyTypeRejectionProtocol']
  Execute Javascript  document.querySelector("input[id^='rejectQualificationInput']").className = ''
  Sleep  2s
  Choose File  css=input[id^='rejectQualificationInput']  ${doc_path}
  Wait For Ajax


Дискваліфікувати постачальника
  [Arguments]  ${user_name}  ${tender_id}  ${award_num}  ${description}
  Wait Until Element Is Visible  css=button[tid='btn.award.unsuccessful']  ${COMMONWAIT}
  Click Button  css=button[tid='btn.award.unsuccessful']
  Wait For Ajax
  Reload Page


Завантажити протокол скасування в контракт
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${contract_index}
  privatmarket.Завантажити протокол дискваліфікації в авард  ${username}  ${tender_uaid}  ${filepath}  ${contract_index}


Скасувати контракт
  [Arguments]  ${username}  ${tender_id}  ${contract_num}
  Wait Until Element Is Visible  css=button[tid='btn.award.unsuccessful']  ${COMMONWAIT}
  Click Button  css=button[tid='btn.award.unsuccessful']
  Wait For Ajax
  Reload Page


Внести зміни в поле
  [Arguments]  ${elementLocator}  ${input}
  Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
  Input Text  ${elementLocator}  ${input}
  Run Keyword If
    ...  '${MODE}' == 'assets'  Wait Enable And Click Element  css=button[tid='btn.createasset']
    ...  ELSE IF  '${MODE}' == 'lots'  Wait Enable And Click Element  css=button[tid="btn.createInfo"]


Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  ${doc}=  Set Variable  xpath=//div[@id='fileitem' and contains(., '${doc_id}')]
  ${file_name}=  Get Element Attribute  ${doc}@title
  ${file_url}=  Get Element Attribute  ${doc}@url
  openprocurement_client_helper.download_file_from_url  ${file_url}  ${OUTPUT_DIR}${/}${file_name}
  Sleep  5s
  [Return]  ${file_name}


Отримати status об'єкту МП
  [Arguments]  ${element}
  Reload Page
  Sleep  5s
  ${element_text}=  Get Text  xpath=//span[@tid='data.statusName']/span[1]
  ${text}=  Strip String  ${element_text}
  ${text}=  Replace String  ${text}  ${\n}  ${EMPTY}
  ${result}=  Set Variable If
  ...  '${text}' == 'Чернетка'  draft
  ...  '${text}' == 'Опубліковано. Очікування інформаційного повідомлення'  pending
  ...  '${text}' == 'Публікація інформаційного повідомлення'  verification
  ...  '${text}' == 'Інформаційне повідомлення опубліковано'  active
  ...  '${text}' == 'Аукціон завершено'  complete
  ...  '${text}' == 'Виключено з переліку'  deleted
  ...  ${element}
  [Return]  ${result}


Отримати registrationDetails.status
  [Arguments]  ${element}
  ${text}=  Отримати текст елемента  ${element}
  ${result}=  Set Variable If
  ...  '${text}' == 'невідомо (не застосовується)'  unknown
  ...  '${text}' == 'об’єкт реєструється'  registering
  ...  '${text}' == 'об’єкт зареєстровано'  complete
  ...  ${element}
  [Return]  ${result}


Отримати creationDate
  [Arguments]  ${field_name}
  ${result}=  Get Element Attribute  ${tender_data_${field_name}}@data-date
  [Return]  ${result}


Отримати дату внесення змін
  [Arguments]  ${field_name}
  ${result}=  Get Element Attribute  ${tender_data_${field_name}}@data-date
  [Return]  ${result}


Отримати rectificationPeriod.endDate
  [Arguments]  ${field_name}
  ${result}=  Get Element Attribute  ${tender_data_${field_name}}@data-enddate
  [Return]  ${result}


Отримати lot_dates
  [Arguments]  ${field_name}
  ${result}=  Get Element Attribute  ${lot_data_${field_name}}@tidvalue
  [Return]  ${result}


Отримати documents[0].documentType
  [Arguments]  ${field_name}
  ${result}=  Get Element Attribute  ${tender_data_${field_name}}@data-docType
  [Return]  ${result}


Отримати status лоту
  [Arguments]  ${element}
  Reload Page
  Sleep  5s
  ${element_text}=  Get Text  xpath=//span[@tid='data.statusName']/span[1]
  ${text}=  Strip String  ${element_text}
  ${text}=  Replace String  ${text}  ${\n}  ${EMPTY}
  ${result}=  Set Variable If
  ...  '${text}' == 'Чернетка'  draft
  ...  '${text}' == 'Публікація інформаційного повідомлення'  composing
  ...  '${text}' == 'Перевірка доступності об’єкту'  verification
  ...  '${text}' == 'Опубліковано'  pending
  ...  '${text}' == 'Об’єкт виставлено на продаж'  active.salable
  ...  '${text}' == 'Аукціон'  active.auction
  ...  '${text}' == 'Аукціон завершено. Кваліфікація'  active.contracting
  ...  '${text}' == 'Аукціон завершено'  pending.sold
  ...  '${text}' == 'Аукціон завершено. Об’єкт не продано'  pending.dissolution
  ...  '${text}' == 'Об’єкт продано'  sold
  ...  '${text}' == 'Об’єкт не продано'  dissolved
  ...  '${text}' == 'Об’єкт виключено'  deleted
  ...  ${element}
  [Return]  ${result}


Отримати status аукціону
  [Arguments]  ${element}
  Reload Page
  Sleep  5s
  ${element_text}=  Get Text  xpath=//span[@tid='data.statusName']/span[1]
  ${text}=  Strip String  ${element_text}
  ${text}=  Replace String  ${text}  ${\n}  ${EMPTY}
  ${result}=  Set Variable If
  ...  '${text}' == 'Аукціон відмінено'  cancelled
  ...  '${text}' == 'Аукціон не відбувся'  unsuccessful
  ...  '${text}' == 'Аукціон відбувся (або 1 учасник)'  complete
  ...  '${text}' == 'Очікується підписання договору'  active.awarded
  ...  '${text}' == 'Очікується опублікування протоколу'  active.qualification
  ...  '${text}' == 'Аукціон'  active.auction
  ...  '${text}' == 'Прийняття заяв на участь'  active.tendering
  ...  ${element}
  [Return]  ${result}


Отримати посилання на аукціон для глядача
  [Arguments]  ${user_name}  ${tender_id}  ${lot_id}=${Empty}
  Switch Browser  ${ALIAS_NAME}
  Wait For Element With Reload  css=a[tid='public.data.auctionUrl']  5
  ${url}=  Get Element Attribute  css=a[tid='public.data.auctionUrl']@href
  [Return]  ${url}


Отримати посилання на аукціон для учасника
  [Arguments]  ${user_name}  ${tender_id}  ${lot_id}=${Empty}
  Switch Browser  ${ALIAS_NAME}
  Go To  ${USERS.users['${username}'].homepage}
  Run Keyword And Ignore Error  Login  ${user_name}
  privatmarket.Пошук тендера по ідентифікатору  ${user_name}  ${tender_id}
  ${url}=  privatmarket.Отримати посилання на аукціон для глядача  ${user_name}  ${tender_id}
  [Return]  ${url}


Отримати кількість авардів в тендері
  [Arguments]  ${user_name}  ${tender_id}
  Switch Browser  ${ALIAS_NAME}
  ${number_of_awards}=  Get Matching Xpath Count  xpath=//div[@ng-repeat='award in data.awards']
  ${result}=  Convert To Number  ${number_of_awards}
  [Return]  ${result}


Get Cancellation Status
  [Arguments]  ${element}
  Wait Until Element Is Visible  ${element}
  ${element_text}=  Get Text  ${element}
  ${text}=  Strip String  ${element_text}
  ${result}=  Set Variable If
  ...  '${text}' == 'Аукціон відмінено'  active
  ...  ${element}
  [Return]  ${result}


Отримати awards status
  [Arguments]  ${element}
  Sleep  25s
  Reload Page
  Wait For Ajax
  ${text}=  Get Element Attribute  ${procedure_data_${element}}@tidvalue
  [Return]  ${text}


Отримати дату
  [Arguments]  ${field_name}
  Switch Browser  ${ALIAS_NAME}
  ${result_full}=  Get Text  ${tender_data_${field_name}}
  ${result_full}=  Convert Date  ${result_full}  date_format=%d-%m-%Y
  [Return]  ${result_full}


Отримати дату з рішення
  [Arguments]  ${field_name}
  ${result_full}=  Get Text  ${lot_data_${field_name}}
  ${result_full}=  Split String  ${result_full}  -
  ${day_length}=  Get Length  ${result_full[0]}
  ${day}=  Set Variable If  '${day_length}' == '1'  0${result_full[0]}  ${result_full[0]}
  ${month}=  Set Variable  ${result_full[1]}
  ${year}=  Set Variable  ${result_full[2]}
  ${result}=  Set Variable  ${year}-${month}-${day}
  [Return]  ${result}


Завантажити документ про зміни
  [Arguments]  ${username}    ${tender_id}
  ${file_path}  ${file_name}  ${file_content}=  create_fake_doc
  Execute Javascript  document.querySelector("input[id='input-doc-info']").className = ''
  Sleep  2s
  Choose File  css=input[id='input-doc-info']  ${file_path}
  Sleep  10s
  Wait Until Element Is Visible  xpath=(//select[@tid="doc.type"])[last()]
  Select From List  xpath=(//select[@tid="doc.type"])[last()]  string:technicalSpecifications
  Sleep  2s


Завантажити ілюстрацію в об'єкт МП
  [Arguments]  ${user_name}  ${tender_id}  ${image_path}
  Wait Enable And Click Element  css=button[tid="btn.modifyLot"]
  Wait Until Element Is Visible  css=button[tid="btn.createasset"]
  Execute Javascript  document.querySelector("input[id='input-doc-asset']").className = ''
  Sleep  2s
  Choose File  css=input[id='input-doc-asset']  ${image_path}
  Sleep  10s
  Wait Until Element Is Visible  css=select[tid="doc.type"]
  Select From List  css=select[tid="doc.type"]  string:illustration
  Sleep  2s
  Wait Enable And Click Element  css=button[tid="btn.createasset"]


Завантажити ілюстрацію в лот
  [Arguments]  ${username}  ${tender_id}  ${image_path}
  Wait Enable And Click Element  css=button[tid="btn.modifyLot"]
  Execute Javascript  document.querySelector("input[id='input-doc-info']").className = ''
  Sleep  2s
  Choose File  css=input[id='input-doc-info']  ${image_path}
  Sleep  10s
  Wait Until Element Is Visible  css=select[tid="doc.type"]
  Select From List  css=select[tid="doc.type"]  string:illustration
  Sleep  2s
  Wait Enable And Click Element  css=button[tid="btn.createInfo"]


Завантажити документ в об'єкт МП з типом
  [Arguments]  ${user_name}  ${tender_id}  ${file_path}  ${doc_type}
  Wait Enable And Click Element  css=button[tid="btn.modifyLot"]
  Wait Until Element Is Visible  css=button[tid="btn.createasset"]
  Execute Javascript  document.querySelector("input[id='input-doc-asset']").className = ''
  Sleep  2s
  Choose File  css=input[id='input-doc-asset']  ${file_path}
  Sleep  10s
  Wait Until Element Is Visible  xpath=(//select[@tid="doc.type"])[last()]
  Select From List  xpath=(//select[@tid="doc.type"])[last()]  string:${doc_type}
  Sleep  2s
  Wait Enable And Click Element  css=button[tid="btn.createasset"]


Завантажити документ в лот з типом
  [Arguments]  ${user_name}  ${tender_id}  ${file_path}  ${doc_type}
  Wait Enable And Click Element  css=button[tid="btn.modifyLot"]
  Execute Javascript  document.querySelector("input[id='input-doc-info']").className = ''
  Sleep  2s
  Choose File  css=input[id='input-doc-info']  ${file_path}
  Sleep  10s
  Wait Until Element Is Visible  xpath=(//select[@tid="doc.type"])[last()]
  Select From List  xpath=(//select[@tid="doc.type"])[last()]  string:${doc_type}
  Sleep  2s
  Wait Enable And Click Element  css=button[tid="btn.createInfo"]


Завантажити документ в умови проведення аукціону
  [Arguments]  ${user_name}  ${tender_id}  ${file_path}  ${doc_type}  ${auction_index}
  privatmarket.Завантажити документ в лот з типом  ${user_name}  ${tender_id}  ${file_path}  ${doc_type}


Завантажити документ для видалення об'єкта МП
  [Arguments]  ${user_name}  ${tender_id}  ${file_path}
  Wait Enable And Click Element  css=button[tid="btn.cancellationLot"]
  Execute Javascript  document.querySelector("input[id='docsCancellation']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsCancellation']  ${file_path}
  Sleep  10s
  Wait Enable And Click Element  css=button[tid='btn.cancellation']


Завантажити документ для видалення лоту
  [Arguments]  ${user_name}  ${tender_id}  ${file_path}
  privatmarket.Завантажити документ для видалення об'єкта МП  ${user_name}  ${tender_id}  ${file_path}


Отримати кількість активів в об'єкті МП
  [Arguments]  ${user_name}  ${tender_id}
  ${count}=  Get Matching Xpath Count  //div[@ng-repeat="item in data.items"]
  [Return]  ${count}


Додати актив до об'єкта МП
  [Arguments]  ${user_name}  ${tender_id}  ${item}
  Wait Enable And Click Element  css=button[tid="btn.modifyLot"]
  Wait Visibility And Click Element  css=button[tid="btn.additem"]
  Sleep  1s
  Input text  xpath=(//textarea[@tid="item.description"])[last()]  ${item.description}
  #classification
  Input text  xpath=(//div[@tid='classification']//input)[last()]  ${item.classification.id}
  Wait Until Element Is Enabled  xpath=(//ul[contains(@class, 'ui-select-choices-content')])[last()]
  Wait Enable And Click Element  xpath=//span[@class='ui-select-choices-row-inner' and contains(., '${item.classification.id}')]
  #quantity
  ${quantity}=  Convert To String  ${item.quantity}
  Input text  xpath=(//input[@tid='item.quantity'])[last()]  ${quantity}
  Select From List  xpath=(//select[@tid='item.unit.name'])[last()]  ${item.unit.name}
  #address
  Select Checkbox  xpath=(//input[@tid='item.address.checkbox'])[last()]
  Input text  xpath=(//input[@tid='item.address.countryName'])[last()]  ${item.address.countryName}
  Input text  xpath=(//input[@tid='item.address.postalCode'])[last()]  ${item.address.postalCode}
  Input text  xpath=(//input[@tid='item.address.region'])[last()]  ${item.address.region}
  Input text  xpath=(//input[@tid='item.address.streetAddress'])[last()]  ${item.address.streetAddress}
  Input text  xpath=(//input[@tid='item.address.locality'])[last()]  ${item.address.locality}
  Sleep  1s
  Select From List  xpath=(//select[@tid='registrationDetails.status'])[last()]  string:${item.registrationDetails.status}
  Sleep  1s
  Wait Enable And Click Element  css=button[tid="btn.createasset"]
  Wait For Element With Reload  xpath=//div[text()='${item.description}']


Завантажити протокол аукціону в авард
  [Arguments]  ${username}  ${tender_id}  ${file_path}  ${award_index}
  Wait Until Element Is Visible  xpath=//*[@tid='docProtocol']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='docsProtocolI']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsProtocolI']  ${file_path}
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='confirmProtocol']  ${COMMONWAIT}
  Click Element  css=button[tid='confirmProtocol']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Підтвердити постачальника
  [Arguments]  ${username}  ${tender_id}  ${award_num}
  privatmarket.Пошук тендера по ідентифікатору  ${user_name}  ${tender_id}


Завантажити угоду до тендера
  [Arguments]  ${username}  ${tender_id}  ${contract_num}  ${file_path}
  Wait Until Element Is Visible  xpath=//*[@tid='docContract']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='docsContractI']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsContractI']  ${file_path}
  Sleep  10s
  Wait For Ajax
  Wait Until Element Is Enabled  xpath=//*[@tid='contractConfirm']  ${COMMONWAIT}
  Click Element  xpath=//*[@tid='contractConfirm']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Встановити дату підписання угоди
  [Arguments]  ${username}  ${tender_id}  ${contract_index}  ${fieldvalue}
  ${date}=  Get New Auction Date  ${fieldvalue}
  ${hours}=  Get Regexp Matches  ${fieldvalue}  T(\\d{2})  1
  ${mins}=  Get Regexp Matches  ${fieldvalue}  T\\d{2}:(\\d{2})  1
  Wait Until Element Is Enabled  css=input[tid='contractSignDate']  ${COMMONWAIT}
  Input Text  css=input[tid='contractSignDate']  ${date}
  Input Text  css=input[ng-model='hours']  ${hours}
  Input Text  css=input[ng-model='minutes']  ${mins}


Підтвердити підписання контракту
  [Arguments]  ${username}  ${tender_id}  ${contract_num}
  Wait Enable And Click Element  css=label[tid="contractActivate"]


Завантажити протокол погодження в авард
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
  Wait Until Element Is Visible  xpath=//*[@tid='docProtocol']  ${COMMONWAIT}
  Execute Javascript  document.querySelector("input[id='docsProtocolI']").className = ''
  Sleep  2s
  Choose File  css=input[id='docsProtocolI']  ${filepath}
  Wait For Ajax


Активувати кваліфікацію учасника
  [Arguments]  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  css=button[tid='confirmProtocol']  ${COMMONWAIT}
  Click Element  css=button[tid='confirmProtocol']
  Wait For Ajax
  Wait Until Element Is Visible  css=button[tid='defaultOk']  ${COMMONWAIT}
  Click Element  css=button[tid='defaultOk']


Login
  [Arguments]  ${username}
  Sleep  15s
  Wait Enable And Click Element  css=a[ui-sref='modal.login']
  Login with email  ${username}
  ${notification_visibility}=  Run Keyword And Return Status  Wait Until Element Is Visible  css=button[ng-click='later()']
  Run Keyword If  '${notification_visibility}' == 'True'  Click Element  css=button[ng-click='later()']
  Wait For Ajax
  Wait Until Element Is Visible  css=input[tid='global.search']  ${COMMONWAIT}


Login with P24
  [Arguments]  ${username}
  Wait Enable And Click Element  xpath=//a[contains(@href, 'https://bankid.privatbank.ua')]
  Wait Until Element Is Visible  id=inputLogin  5s
  Input Text  id=inputLogin  +${USERS.users['${username}'].login}
  Input Text  id=inputPassword  ${USERS.users['${username}'].password}
  Click Element  css=.btn.btn-success.custom-btn
  Wait Until Element Is Visible  css=input[id='first-section']  5s
  Input Text  css=input[id='first-section']  12
  Input Text  css=input[id='second-section']  34
  Input Text  css=input[id='third-section']  56
  Sleep  1s
  Click Element  css=.btn.btn-success.custom-btn-confirm.sms
  Sleep  3s
  Wait For Ajax


Login with email
  [Arguments]  ${username}
  Wait Until Element Is Visible  css=input[id='email']  5s
  Input Text  css=input[id='email']  ${USERS.users['${username}'].login}
  Input Text  css=input[id='password']  ${USERS.users['${username}'].password}
  Click Element  css=button[type='submit']
  Sleep  3s
  Wait For Ajax


Wait For Ajax
  Get Location
  Sleep  4s


Wait Enable And Click Element
  [Arguments]  ${elementLocator}
  Wait Until Element Is Enabled  ${elementLocator}  ${COMMONWAIT}
  Click Element  ${elementLocator}
  Wait For Ajax


Wait Visibility And Click Element
    [Arguments]  ${elementLocator}
    Wait Until Element Is Visible  ${elementLocator}  ${COMMONWAIT}
    Click Element  ${elementLocator}


Wait For Auction
  [Arguments]  ${tender_id}
  Wait Until Keyword Succeeds  5min  10s  Try Search Auction  ${tender_id}


Try Search Auction
  [Arguments]  ${tender_id}
  Wait For Ajax
  Wait Until element Is Enabled  css=input[tid='global.search']  ${COMMONWAIT}
  ${text_in_search}=  Get Value  css=input[tid='global.search']

  Run Keyword Unless  '${tender_id}' == '${text_in_search}'  Run Keywords  Clear Element Text  css=input[tid='global.search']
  ...  AND  Input Text  css=input[tid='global.search']  ${tender_id}

  Press Key  css=input[tid='global.search']  \\13
  Wait For Ajax
  Wait Until Element Is Visible  css=div[tid='${tender_id}']  ${COMMONWAIT}
  [Return]  True


Wait For Element With Reload
  [Arguments]  ${locator}  ${time_to_wait}=4
  Wait Until Keyword Succeeds  ${time_to_wait}min  15s  Try Search Element  ${locator}


Try Search Element
  [Arguments]  ${locator}
  Reload Page
  Wait For Ajax
  Wait Until Element Is Visible  ${locator}  7
  Wait Until Element Is Enabled  ${locator}  5
  [Return]  True


Get New Auction Date
  [Arguments]  ${element}
  ${result}=  Split String  ${element}  T
  ${date}=  Set Variable  ${result[0]}
  ${correctDate}=  Convert Date  ${date}  result_format=%d/%m/%Y
  [Return]  ${correctDate}


Змінити дату аукціону
  [Arguments]  ${value}
  Wait Enable And Click Element  xpath=//button[@tid='auction.period.btn']
  Wait Enable And Click Element  xpath=(//button[@ng-click='select(dt.date)']//span)[text()='${value}']
  Wait Enable And Click Element  css=button[tid="btn.createInfo"]


Отримати текст елемента
  [Arguments]  ${element_name}
  ${temp_name}=  Remove String  ${element_name}  '
  ${selector}=  Set Variable If
  ...  'css=' in '${temp_name}' or 'xpath=' in '${temp_name}'  ${element_name}
  ...  ${tender_data.${element_name}}
  Wait Until Element Is Visible  ${selector}
  ${result_full}=  Get Text  ${selector}
  ${result}=  Strip String  ${result_full}
  [Return]  ${result}


Отримати число
  [Arguments]  ${element_name}
  ${value}=  Отримати текст елемента  ${element_name}
  ${value}=  Replace String  ${value}  ${SPACE}  ${EMPTY}
  ${value}=  Replace String  ${value}  ,  .
  ${result}=  Convert To Number  ${value}
  [Return]  ${result}


Отримати дату та час
  [Arguments]  ${element_name}
  Switch Browser  ${ALIAS_NAME}
  ${result_full}=  Отримати текст елемента  ${element_name}
  ${result_full}=  Split String  ${result_full}
  ${day_length}=  Get Length  ${result_full[0]}
  ${day}=  Set Variable If  '${day_length}' == '1'  0${result_full[0]}  ${result_full[0]}
  ${month}=  Replace String  ${result_full[1]}  ,  ${EMPTY}
  ${month}=  get month number  ${month}
  ${year}=  get_current_year
  ${result_full}=  Set Variable  ${day}-${month}-${year} ${result_full[2]}
  ${result}=  get_time_with_offset  ${result_full}
  [Return]  ${result}