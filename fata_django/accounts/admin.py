from django.contrib import admin
from django import forms
from django.contrib.admin.widgets import FilteredSelectMultiple
from django.contrib.auth.forms import ReadOnlyPasswordHashField
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from accounts.models import Consumer, Role, Deportment


class ConsumerCreationForm(forms.ModelForm):
    """A form for creating new users. Includes all the required
        fields, plus a repeated password."""
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Password confirmation', widget=forms.PasswordInput)

    class Meta:
        model = Consumer
        widgets = {
            'groups': FilteredSelectMultiple,
        }
        fields = ('open_code', 'date_joined')

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords dont't match")
        return password2

    def save(self, commit=True):
        # Save the provided password in hashed format
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user

class ConsumerChangeForm(forms.ModelForm):
    password = ReadOnlyPasswordHashField()

    class Meta:
        model = Consumer
        widgets = {
            'groups': FilteredSelectMultiple('groups', 1),
        }
        fields = ('open_code', 'password', 'mobile', 'email', 'is_delete', 'is_active', 'is_staff', 'is_admin')

    def clean_password(self):
        return self.initial["password"]

class ConsumerAdmin(BaseUserAdmin):

    form = ConsumerChangeForm
    add_form = ConsumerCreationForm

    list_display = ('id', 'open_code', 'category', 'name', 'mobile', 'email', 'is_active', 'status')

    fieldsets = (
        ('登录信息', {'fields': ('open_code', 'category', 'password')}),
        ('基本信息', {'fields': ('name', 'mobile', 'sex', 'email', 'avator', 'role', 'dept', 'is_delete', 'status')}),
        ('系统权限', {'fields': ('is_admin', 'is_active', 'is_staff')}),
        ('数据权限', {'fields': ('groups',)}),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide', 'extrapretty'),
            'fields': ('open_code', 'password1', 'password2'), }
         ),
    )

    search_fields = ('name', 'mobile')
    list_filter = ('category',)
    ordering = ('name',)
    filter_horizontal = ()

class RoleAdmin(admin.ModelAdmin):
    list_display = ('id', 'code', 'name', 'intro', 'status', 'creator')
    list_filter = ('status', )
    search_fields = ('code', 'name')

#部门组织管理
class DeportmentAdmin(admin.ModelAdmin):
    list_display = ('id','name')
    search_fields = ('name',)

admin.site.site_header = '阀塔漏水监测系统'
admin.site.site_title = '阀塔漏水监测系统'
admin.site.register(Consumer, ConsumerAdmin)
admin.site.register(Role, RoleAdmin)
admin.site.register(Deportment,DeportmentAdmin)