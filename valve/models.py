from django.db import models
from django.conf import settings
from common.models import BaseModel


# 生产厂家基本信息
class Manufactor(BaseModel):

    name = models.CharField(max_length=255, null=True, blank=True, verbose_name="厂家名称")
    address = models.CharField(max_length=255, null=True, blank=True, verbose_name="厂家地址")

    # 状态信息
    creator = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.PROTECT,
                                verbose_name="创建人", related_name='manufactor_creator')
    modifier = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.PROTECT,
                                 verbose_name="修改人", related_name='manufactor_modifier')
    status = models.BooleanField(default=True, verbose_name="当前状态")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "生产厂家基本信息"
        verbose_name_plural = '生产厂家基本信息'

# 传感器设备
class Sensor(BaseModel):

    name = models.CharField(max_length=255, null=True, blank=True, verbose_name="传感器名称")
    code = models.CharField(max_length=255, null=True, blank=True, verbose_name="传感器型号")
    serial_number = models.CharField(max_length=255, unique=True, null=True, blank=True, verbose_name="传感器唯一编号")
    manufactor = models.ForeignKey(Manufactor, null=True, blank=True, on_delete=models.SET_NULL, verbose_name='生产厂家',
                             related_name='sensor_manufactor')

    # 状态信息
    creator = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.PROTECT,
                                verbose_name="创建人", related_name='sensor_creator')
    modifier = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.PROTECT,
                                 verbose_name="修改人", related_name='sensor_modifier')
    status = models.BooleanField(default=True, verbose_name="当前状态")

    def  __str__(self):
        return self.name

    class Meta:
        verbose_name = "传感器设备"
        verbose_name_plural = '传感器设备'

# 电压测量记录
class Voltage(BaseModel):

    sensor = models.ForeignKey(Sensor, null=True, blank=True, on_delete=models.SET_NULL, verbose_name='所属传感器',
                                   related_name='valtage_senor')
    voltage = models.CharField(max_length=255, null=True, blank=True, verbose_name="电压测量量")

    # 状态信息
    status = models.BooleanField(default=True, verbose_name="当前状态")

    def  __str__(self):
        return self.voltage

    @property
    def sensor_name(self):
        return self.sensor.name

    class Meta:
        verbose_name = "电压测量记录"
        verbose_name_plural = '电压测量记录'

# 告警信息
class WarnInfo(BaseModel):

    sensor = models.ForeignKey(Sensor, null=True, blank=True, on_delete=models.SET_NULL, verbose_name='所属传感器',
                                   related_name='warn_senor')
    warn_info = models.CharField(max_length=255, null=True, blank=True, verbose_name="告警信息")


    def  __str__(self):
        return self.warn_info

    @property
    def sensor_name(self):
        return self.sensor.name

    class Meta:
        verbose_name = "告警信息记录"
        verbose_name_plural = '告警信息记录'