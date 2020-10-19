import time
from builtins import property

from django.utils import timezone
from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.db import models

# Create your models here.
from django.conf import settings
from common.models import BaseModel, ConsumerManager

USER_TYPE = (
    ('mangage', '管理角色'),
    ('maintain','运维人员')
)
SEX = (
    ('male', '男'),
    ('female', '女'),
    ('other', '未知'),
)
COMPANYTYPE = (
    ('admin','管理'),
    ('maintain','运维')
)

data_type_choices = (
    ('全部', '全部'),
    ('同级及以下', '同级及以下'),
    ('本级及以下', '本级及以下'),
    ('本级', '本级'),
    ('仅本人', '仅本人')
)

SENDORDER = (
    ('not_send_order','尚未派单'),
    ('send_order','派单完成'),
    ('not_dispose','未处理'),
    ('dispose','处理')
)
OPERATIONALTYPE = (
    ('weixiugongdan','维修工单'),
    ('chakangongdan','巡检工单')
)
OPERATIONALSTETE = (
    ('urgency','紧急'),
    ('common','一般')
)




#用户组织表
class Deportment(BaseModel):

    parent = models.ForeignKey('self', null=True, blank=True, related_name='department_children', on_delete=models.SET_NULL,
                               verbose_name="所属父级组织")
    name  = models.CharField(max_length=64,verbose_name='组织名称',null=True,blank=True)
    organization_type = models.CharField(choices=COMPANYTYPE,max_length=18,null=True,blank=True,verbose_name="组织类型")

    belong_dept = models.ForeignKey('accounts.Deportment', null=True, blank=True, verbose_name='数据权限部门',
                                    on_delete=models.CASCADE, related_name='dep_department_data')
    create_by = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, verbose_name='创建人',
                                  on_delete=models.SET_NULL, related_name='dep_create_by_msg')
    update_by = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, verbose_name='编辑人',
                                  on_delete=models.SET_NULL, related_name='dep_update_by_msg')


    def  __str__(self):
        return self.name

    class Meta:
        verbose_name = "用户组织表"
        verbose_name_plural = '用户组织表'



# 角色表
class Role(models.Model):

    parent = models.ForeignKey('self', null=True, blank=True, related_name='children', on_delete=models.PROTECT,
                               verbose_name="所属父级角色")
    code = models.CharField(max_length=255, unique=True,null=True,blank=True, verbose_name="角色唯一CODE代码")
    name = models.CharField(max_length=64, verbose_name="角色名称")
    intro = models.CharField(max_length=255, null=True, blank=True, verbose_name="角色介绍")
    datas = models.CharField('数据权限', max_length=50,choices=data_type_choices, default='本级及以下')
    role_permission_list = models.CharField(max_length=1024,null=True,blank=True,verbose_name="角色权限信息")
    depts = models.ForeignKey(to='Deportment', null=True, blank=True, verbose_name='所属组织', on_delete=models.SET_NULL)

    # 状态信息
    creator = models.ForeignKey(settings.AUTH_USER_MODEL,null=True,blank=True, on_delete=models.PROTECT, verbose_name="创建人",
                                related_name='role_creator')
    modifier = models.ForeignKey(settings.AUTH_USER_MODEL, null=True,blank=True,on_delete=models.PROTECT, verbose_name="修改人",
                                 related_name='role_modifier')
    status = models.BooleanField(default=True, verbose_name="当前状态")

    class Meta:
        verbose_name_plural = "角色表 "

    def __str__(self):
        return "{} - {} - {}".format(self.id, self.name, self.code)

# 用户信息表
class Consumer(AbstractBaseUser, PermissionsMixin):
    # 登录信息
    open_code = models.CharField(max_length=128, unique=True, default='admin', verbose_name="登录账号",
                                 help_text="如手机号、邮箱等")
    category = models.CharField(max_length=32, choices=USER_TYPE, default='maintain', verbose_name="账号类别")
    # 基本信息
    name = models.CharField(max_length=128,  verbose_name="用户姓名")
    mobile = models.CharField(max_length=128, default="", null=True, blank=True, verbose_name="联系电话")
    sex = models.CharField(max_length=32, choices=SEX, default='other', verbose_name="性别")
    email = models.EmailField(max_length=255, unique=True, null=True, blank=True, verbose_name="邮箱")
    avator = models.CharField(max_length=128, null=True, blank=True, verbose_name='用户头像')
    role = models.ManyToManyField(Role, blank=True,related_name='role_consumer', verbose_name="用户角色")

    is_delete = models.BooleanField(default=False, verbose_name="是否删除")
    dept = models.ForeignKey(Deportment, null=True, blank=True, on_delete=models.SET_NULL, verbose_name='组织',related_name='user_deps')
    # 状态信息
    status = models.BooleanField(default=True, verbose_name="是否启用")
    is_active = models.BooleanField(default=True, verbose_name="是否激活")
    is_staff = models.BooleanField(default=False, verbose_name="工作人权限")
    is_admin = models.BooleanField(default=False, verbose_name="超级用户权限")
    date_joined = models.DateTimeField(default=timezone.now, verbose_name="创建日期")
    read_fault = models.TextField(default='[]',null=True,blank=True,verbose_name='用户阅读故障数量')

    objects = ConsumerManager()

    USERNAME_FIELD = 'open_code'
    REQUIRED_FIELDS = []

    class Meta:
        verbose_name_plural = "用户信息表"

    def __str__(self):
        return '{0} {1}'.format(self.name, self.mobile)

    def role_name(self):
        if self.role:
            return self.role.all().first().name
        return ''

    @property
    def get_group_name(self):
        if self.groups.exists():
            return self.groups.all()[0]
        return [i.name for i in self.groups.all()]

#角色按钮表
class RoleButton(BaseModel):

    role = models.ManyToManyField(to='Role',blank=True,verbose_name="所属角色",related_name='role_button')
    name = models.CharField(max_length=32, null=True, blank=True, verbose_name="权限名称")
    code = models.CharField(max_length=32,null=True,blank=True,verbose_name="code码")
    describe = models.CharField(max_length=256,null=True,blank=True,verbose_name="描述")
    belong_menu = models.CharField(max_length=18,null=True,blank=True,verbose_name='所属菜单')
    status = models.BooleanField(default=False,verbose_name="按钮状态")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "角色按钮表"
        verbose_name_plural = "角色按钮表"

#角色菜单目录结构
class RoleMenu(BaseModel):

    content = models.TextField(verbose_name="角色菜单内容")

    class Meta:
        verbose_name = "角色菜单表"
        verbose_name_plural = '角色菜单表'
