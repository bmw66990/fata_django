#用户
from rest_framework import serializers

from accounts.models import Consumer, Role, Deportment, RoleMenu, RoleButton


class AccountsSerializers(serializers.ModelSerializer):

    # password = serializers.SerializerMethodField()
    #
    # def get_password(self,obj):
    #     return ""

    class Meta:
        model = Consumer
        fields = ['id','name','mobile','open_code','role_name','role','category','email','password','dept','is_delete','status']


#角色
class RoleSerializers(serializers.ModelSerializer):


    class Meta:
        model = Role
        fields = ['id','code','name','intro','status','role_permission_list','parent','datas','depts']


#组织

class GroupSerializer(serializers.ModelSerializer):

    parent_name = serializers.SerializerMethodField()

    def get_parent_name(self,obj):
        if obj.parent != None:
            return obj.parent.name
        return ''

    class Meta:
        model  = Deportment
        fields = ['id','name','parent','parent_name','belong_dept','create_by','update_by']


#角色菜单
class RoleMenuSerializers(serializers.ModelSerializer):


    class Meta:
        model  = RoleMenu
        fields  = "__all__"

#角色按钮
class RoleButtonSerializers(serializers.ModelSerializer):

    class Meta:
        model  = RoleButton
        fields =  "__all__"


