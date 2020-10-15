from rest_framework import routers
from django.urls import include, re_path

from valve import views
from valve.viewsets.valve import VoltageViewset
from valve.viewsets.valve import WarnInfoViewset


router = routers.DefaultRouter()
router.register(r'^voltage', VoltageViewset)
router.register(r'^warn', WarnInfoViewset)

urlpatterns = [
    # 首页获取阀塔良好运行天数以及良好运行的起止时间
    re_path('get_normal/', VoltageViewset.as_view({'get': 'get_normal'})),
    # 首页获取各个传感器的电压测量量数据
    re_path('new_voltage/', VoltageViewset.as_view({'get': 'new_voltage'})),
    # 电压测量记录数据导出
    re_path('^export_voltage',views.export_voltage),
    # 告警信息数据导出
    re_path('^export_warn', views.export_warn),
]

urlpatterns += router.urls