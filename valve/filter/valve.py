import django_filters as filters
from valve.models import Voltage, WarnInfo


# 电压测量记录
class VoltageFilter(filters.FilterSet):
    date = filters.CharFilter(method='date_filter', label='时间日期类型', lookup_expr='icontains')
    sensor_id = filters.CharFilter(method='sensor_id_filter', label='所属传感器设备的id', lookup_expr='icontains')

    # 时间日期类型
    def date_filter(self, queryset, name, value):
        date = value.split('-')
        if len(date) == 1:
            return queryset.filter(create_at__year=date[0])
        elif len(date) == 2:
            return queryset.filter(create_at__year=date[0], create_at__month=date[1])
        elif len(date) == 3:
            return queryset.filter(create_at__year=date[0], create_at__month=date[1], create_at__day=date[2])


    # 传感器设备id
    def sensor_id_filter(self, queryset, name, value):
        return queryset.filter(sensor__id=value)

    class Meta:
        model = Voltage
        fields = "__all__"

# 告警信息
class WarnInfoeFilter(filters.FilterSet):
    date = filters.CharFilter(method='date_filter', label='时间日期类型', lookup_expr='icontains')
    sensor_id = filters.CharFilter(method='sensor_id_filter', label='所属传感器设备的id', lookup_expr='icontains')

    # 时间日期类型
    def date_filter(self, queryset, name, value):
        date = value.split('-')
        if len(date) == 1:
            return queryset.filter(create_at__year=date[0])
        elif len(date) == 2:
            return queryset.filter(create_at__year=date[0], create_at__month=date[1])
        elif len(date) == 3:
            return queryset.filter(create_at__year=date[0], create_at__month=date[1], create_at__day=date[2])

    # 传感器设备id
    def sensor_id_filter(self, queryset, name, value):
        return queryset.filter(sensor__id=value)

    class Meta:
        model = WarnInfo
        fields = "__all__"