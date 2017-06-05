from django.shortcuts import render
from django.http import HttpResponse
from django.http import JsonResponse
from bns_info.models import Character, Dungeon, Tactics, Team
from django.shortcuts import get_object_or_404
import json
import hashlib
import time

# Create your views here.
def index(request):
	return HttpResponse("<h1>BnS Information Service</h1>")

#로그인 해서 소속 정보 전달.
def login(request): 
    if request.method == 'POST': 
        data = request.body.decode("utf-8")
        receivedData = json.loads(data)

        receivedName = receivedData['characterName'] 
        character = Character.objects.get(name=receivedName) 
        team = Team.objects.get(teamNum=character.teamNum)
        teamDungeonType = Dungeon.objects.get(dType=team.dType)

        retValue = {character.teamNum : teamDungeonType.dType} 
        return JsonResponse(retValue, safe=False)

    else: 
        return HttpResponse('Request is not POST method.')

#팀 선택하면 역할 전달.
def getRoleNum(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		tactics = Tactics.objects.get(teamNum=receivedData['teamNum'], cName=receivedData['cName'], dType=receivedData['dType'])
		role = {tactics.namedNum : tactics.role}

		return JsonResponse(role, safe=False)

	else:
		return HttpResponse('Request is not POST method.')

#팀 생성
def setTeam(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		Leader = receivedData['teamLeader']
		DungeonType = receivedData['dType']

		teamNumber = hashlib.md5()
		hashKey = Leader + DungeonType + time.time()
		teamNumber.update(hashKey)

		newTeam = Team(teamLeader=Leader,
			teamNum=teamNumber,
			dType=DungeonType)
		newTeam.save()

		return HttpResponse('done')

	else:
		return HttpResponse('error')

#팀 멤버 추가
def setTeamMember(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		characterName = receivedData['characterName']
		teamNumber = receivedData['teamNumber']
		cRole = receivedData['role']
		DungeonType = receivedData['dType']

		newRole = Tactics(cName=characterName,
			teamNum=teamNumber,
			role=cRole,
			dType=DungeonType,
			namedNum=None)
		newRole.save()

		return HttpResponse('done')


	else:
		return HttpResponse('error')


		

























