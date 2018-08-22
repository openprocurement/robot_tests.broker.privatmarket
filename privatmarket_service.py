# coding=utf-8

from datetime import datetime
from datetime import timedelta
from pytz import timezone
import dateutil.parser
import sys
import re


def modify_test_data(tender_data):
    tender_data['data']['assetCustodian']['identifier']['legalName'] = u'Тестовый Тестовый'
    tender_data['data']['assetCustodian']['identifier']['id'] = u'32855961'
    if 'contactPoint' in tender_data['data']['assetCustodian']:
        tender_data['data']['assetCustodian']['contactPoint']['telephone'] = u'+380123456789'
        tender_data['data']['assetCustodian']['contactPoint']['email'] = u'tadud@p33.org'
        tender_data['data']['assetCustodian']['contactPoint']['name'] = u'Тестовый Тестовый'
    return tender_data


def get_current_year():
    now = datetime.now()
    return now.year


def get_month_number(month_name):
    monthes = [u"січня", u"лютого", u"березня", u"квітня", u"травня", u"червня",
               u"липня", u"серпня", u"вересня", u"жовтня", u"листопада", u"грудня",
               u"January", u"February", u"March", u"April", u"May", u"June",
               u"July", u"August", u"September", u"October", u"November", u"December"]
    return monthes.index(month_name) % 12 + 1


def get_time_with_offset(date):
    date_obj = datetime.strptime(date, "%d-%m-%Y %H:%M")
    time_zone = timezone('Europe/Kiev')
    localized_date = time_zone.localize(date_obj)
    return localized_date.strftime('%Y-%m-%d %H:%M:%S.%f%z')


def increase_date_on_days(date, days):
    date = dateutil.parser.parse(date).date()
    date += timedelta(days=int(days))
    return date.strftime('%d/%m/%Y')


def get_accelerator(scenarios):
    m = re.search('/(\w*)', scenarios)
    scenarios = m.group(1)
    actives_and_lots = ["ssp_full_registry", "ssp_delete_asset", "ssp_delete_lot"]
    if scenarios in actives_and_lots:
        return 150
    else:
        return 1440


def get_scenarios_name():
    name = ''
    for param in sys.argv:
        if 'txt' in param:
            name = param
    return name
