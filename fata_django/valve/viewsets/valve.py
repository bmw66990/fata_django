import datetime

from rest_framework import status
from rest_framework.decorators import action

from common.utils.response import JsonResponse
from common.viewset import CustomViewBase
from valve.models import Voltage, WarnInfo, Sensor
from valve.serializers import VoltageSerializers, WarnInfoSerializers
from valve.filter.valve import VoltageFilter, WarnInfoeFilter

# 电压测量记录
class VoltageViewset(CustomViewBase):
    queryset = Voltage.objects.all()
    serializer_class = VoltageSerializers
    filter_class = VoltageFilter
    filterset_fields = "__all__"

    # 计算两个日期之间的时间差
    def subtime(self, date1, date2):
        print('date1:', date1, 'date2:', date2)
        date1 = datetime.datetime.strptime(date1, "%Y-%m-%d")
        date2 = datetime.datetime.strptime(date2, "%Y-%m-%d")

        return date2 - date1

    # 首页变电所整体分析
    @action(methods=['get'], detail=False)
    def get_normal(self, request):
        msg = '数据获取成功'
        response = {}

        now = datetime.datetime.now().strftime("%Y-%m-%d")

        warn = list(WarnInfo.objects.order_by('-create_at').values()[:1])
        warn_create = warn[0]['create_at'].strftime("%Y-%m-%d")
        print(self.subtime(warn_create, now))
        response['time'] = warn_create + '--' + now
        response['day'] = self.subtime(warn_create, now)/86400

        return JsonResponse(data=response, code=status.HTTP_200_OK, msg=msg, status=status.HTTP_200_OK)

    # 首页变电所整体分析
    @action(methods=['get'], detail=False)
    def new_voltage(self, request):
        msg = '数据获取成功'

        sensor = Sensor.objects.all()
        warn = Voltage.objects.all()
        response = []
        for i in sensor:
            warn_info = {}
            # print('name:', i.name)
            data = list(warn.filter(sensor=i).order_by('-create_at').values())
            warn_info['name'] = i.name
            if len(data) == 0:
                warn_info['voltage'] = '0-0'
            else:
                warn_info['voltage'] = data[0]['voltage']
            response.append(warn_info)


        return JsonResponse(data=response, code=status.HTTP_200_OK, msg=msg, status=status.HTTP_200_OK)

# 告警信息
class WarnInfoViewset(CustomViewBase):
    queryset = WarnInfo.objects.all()
    serializer_class = WarnInfoSerializers
    filter_class = WarnInfoeFilter
    filterset_fields = "__all__"