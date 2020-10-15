from django.urls import path, include
from accounts import views
from accounts.viewsets import accounts_view
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
# 用户管理
router.register(r'message',accounts_view.AccountViewset)
#角色管理
router.register(r'role',accounts_view.RoleViewset)
#组织管理
router.register(r'department',accounts_view.DepartmentViewset)
#角色菜单目录接口
router.register(r'rolemenu',accounts_view.RoleMenuViewsets)
#角色按钮接口信息
router.register(r'rolebutton',accounts_view.RoleButtonViewsets)
urlpatterns = [
    path('',include(router.urls)),
    #组织删除增加校验
    path('dep_del/',views.dep_del)
]