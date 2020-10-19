import sys, os, django, datetime

# 本地
sys.path.append('/Users/harden/code/python/valve_tower/api_leakage')
# 生产环境
# sys.path.append('/www/wwwroot/key_project')

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "api_leakage.settings")
django.setup()

from valve.models import Voltage, Sensor


if __name__ == '__main__':
    sensor = Sensor.objects.all()
    warn = Voltage.objects.all()
    shuju = []
    for i in sensor:
        warn_info = {}
        # print('name:', i.name)
        data = list(warn.filter(sensor=i).order_by('-create_at').values())
        warn_info['name'] = i.name
        if len(data) == 0:
            warn_info['voltage'] = '0-0'
        else:
            warn_info['voltage'] = data[0]['voltage']
        shuju.append(warn_info)
    print('shuju:', shuju)
