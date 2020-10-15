from django.http import HttpResponse
from valve.models import Voltage, WarnInfo
from valve.resources import VoltageExportMessage, WarnInfoExportMessage

# 电压测量记录数据导出
def export_voltage(request):
    export_type = request.GET.get('export_voltage', 'xlsx')
    date_type = request.GET.get('date', '')
    sensor_id_type = request.GET.get('sensor_id', '')
    table_name = request.GET.get('table_name', 'voltage')

    queryset = Voltage.objects.all()
    if date_type != '':
        date = date_type.split('-')
        if len(date) == 1:
            queryset = queryset.filter(create_at__year=date[0])
        elif len(date) == 2:
            queryset = queryset.filter(create_at__year=date[0], create_at__month=date[1])
        elif len(date) == 3:
            queryset = queryset.filter(create_at__year=date[0], create_at__month=date[1], create_at__day=date[2])

    if sensor_id_type != '':
        queryset = queryset.filter( sensor__id=sensor_id_type)

    voltate_resources = VoltageExportMessage()
    dataset = voltate_resources.export(queryset)
    # response = ''
    response = HttpResponse(getattr(dataset, export_type), charset='utf-8',
                            content_type='{}/{}'.format(table_name, export_type))
    response['Content-Disposition'] = 'attachment; filename="{}.{}"'.format(table_name, export_type)
    return response

# 告警信息数据导出
def export_warn(request):
    export_type = request.GET.get('export_warninfo', 'xlsx')
    table_name = request.GET.get('table_name', 'warninfo')

    date_type = request.GET.get('date', '')
    sensor_id_type = request.GET.get('sensor_id', '')

    queryset = WarnInfo.objects.all()
    if date_type != '':
        date = date_type.split('-')
        if len(date) == 1:
            queryset = queryset.filter(create_at__year=date[0])
        elif len(date) == 2:
            queryset = queryset.filter(create_at__year=date[0], create_at__month=date[1])
        elif len(date) == 3:
            queryset = queryset.filter(create_at__year=date[0], create_at__month=date[1], create_at__day=date[2])

    if sensor_id_type != '':
        queryset = queryset.filter(sensor__id=sensor_id_type)

    warninfo_resources = WarnInfoExportMessage()
    dataset = warninfo_resources.export(queryset)
    response = HttpResponse(getattr(dataset, export_type), charset='utf-8',
                            content_type='{}/{}'.format(table_name, export_type))
    response['Content-Disposition'] = 'attachment; filename="{}.{}"'.format(table_name, export_type)
    return response
