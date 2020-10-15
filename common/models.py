import datetime

from django.contrib.auth import authenticate
from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import User
from django.db import models

class DictMixin:
    """queryset转字典"""
    def to_dict(self):
        fields = []
        for field in self._meta.fields:
            fields.append(field.name)

        d = {}
        for attr in fields:
            if isinstance(getattr(self, attr), datetime.datetime):
                d[attr] = getattr(self, attr).strftime('%Y-%m-%d %H:%M:%S')
            elif isinstance(getattr(self, attr), datetime.date):
                d[attr] = getattr(self, attr).strftime('%Y-%m-%d')
            elif isinstance(getattr(self, attr), DictMixin):
                d[attr] = getattr(self, attr).to_dict()
            elif isinstance(getattr(self, attr), User):
                d[attr] = getattr(self,attr).username
            else:
                d[attr] = getattr(self, attr)
        return d

# Create your models here.
class BaseModel(models.Model, DictMixin):
    """model 基类"""
    create_at = models.DateTimeField(auto_now_add=True, verbose_name="创建时间")
    modified_at = models.DateTimeField(auto_now=True, verbose_name="更新时间")

    class Meta:
        abstract = True
        default_permissions = ()




class ConsumerManager(BaseUserManager):

    def change_password(self, open_code, old_password, new_password1):
        if not open_code:
            raise ValueError("必须填写登录账号")

        consumer = authenticate(open_code=open_code, password=old_password)
        if consumer is not None:
            consumer.set_password(new_password1)
            consumer.save(using=self._db)
        return consumer

    def create_user(self, open_code,  password=None):
        if not open_code:
            raise ValueError("必须填写登录账号")

        consumer = self.model(open_code=open_code)

        consumer.set_password(password)
        consumer.save(using=self._db)
        return consumer

    def create_superuser(self, open_code, password):
        consumer = self.create_user(
            open_code=open_code,
            password=password
        )
        consumer.is_admin = True
        consumer.is_staff = True
        consumer.is_superuser = True
        consumer.save(using=self._db)
        return consumer

    def bluk_create_user(self, open_code, status, is_staff, password):
        consumer = self.create_user(
            open_code=open_code,
            password=password
        )
        consumer.status = status
        consumer.is_staff = is_staff
        consumer.is_admin = False

        consumer.is_superuser = False
        consumer.save(using=self._db)
        return consumer
