from django.contrib import admin
from valve.models import Manufactor, Sensor, Voltage, WarnInfo

# Register your models here.
class ManufactorAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'address', 'creator')
    list_filter = ('status', )
    search_fields = ('name', 'address')

class SensorAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'code', 'serial_number', 'manufactor', 'creator')
    search_fields = ('code', 'name')

class VoltageAdmin(admin.ModelAdmin):
    list_display = ('id', 'sensor', 'voltage')
    search_fields = ('voltage', 'sensor')

class WarnInfoAdmin(admin.ModelAdmin):
    list_display = ('id', 'sensor', 'warn_info')
    search_fields = ('warn_info', 'sensor')

admin.site.register(Manufactor, ManufactorAdmin)
admin.site.register(Sensor, SensorAdmin)
admin.site.register(Voltage, VoltageAdmin)
admin.site.register(WarnInfo, WarnInfoAdmin)