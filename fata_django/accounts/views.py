from django.http import JsonResponse
from django.shortcuts import render

# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from accounts.models import Deportment

@csrf_exempt
def dep_del(request):
    id = request.POST.get('id',-1)
    if id  != -1:
        dep = Deportment.objects.get(pk=int(id))
        dep_cou = Deportment.objects.filter(parent=dep).count()
        if dep_cou != 0:
            return JsonResponse({'code':400,'msg':'存在子部门不允许删除'})
        else:
            return JsonResponse({'code':200,'msg':'允许删除'})
    return JsonResponse({'code':200,'msg':'输入正确得ID'})