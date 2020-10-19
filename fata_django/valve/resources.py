from import_export import resources
from import_export.fields import Field
from valve.models import Voltage, WarnInfo

# 电压测量记录
class VoltageExportMessage(resources.ModelResource):

    sensor_name = Field(attribute='sensor_name',column_name='传感器设备名称')
    voltage = Field(attribute='voltage',column_name='测量量数据')
    create_at = Field(attribute='create_at',column_name='创建时间')

    def dehydrate_sensor_name(self,model):
        return model.sensor_name

    class Meta:
        model = Voltage
        fields = ('sensor_name', 'voltage', 'create_at')
        export_order = ('sensor_name', 'voltage', 'create_at')

# 告警信息
class WarnInfoExportMessage(resources.ModelResource):

    sensor_name = Field(attribute='sensor_name',column_name='传感器设备名称')
    warn_info = Field(attribute='warn_info',column_name='告警信息')
    create_at = Field(attribute='create_at',column_name='创建时间')

    def dehydrate_sensor_name(self,model):
        return model.sensor_name

    class Meta:
        model = WarnInfo
        fields = ('sensor_name', 'warn_info', 'create_at')
        export_order = ('sensor_name', 'warn_info', 'create_at')