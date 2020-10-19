from rest_framework import serializers
from valve.models import Voltage, WarnInfo

# 电压测量记录
class VoltageSerializers(serializers.ModelSerializer):

    create_at = serializers.DateTimeField(format="%Y-%m-%d %H:%M:%S", required=False, read_only=True)

    class Meta:
        model = Voltage
        fields = '__all__'

# 告警信息
class WarnInfoSerializers(serializers.ModelSerializer):
    create_at = serializers.DateTimeField(format="%Y-%m-%d %H:%M:%S", required=False, read_only=True)

    class Meta:
        model = WarnInfo
        fields = '__all__'
