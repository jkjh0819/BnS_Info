from django.shortcuts import render
from django.http import HttpResponse
from django.http import JsonResponse
from bns_info.models import Character, Dungeon, Tactics, Team

import json
import hashlib
import time

# Create your views here.
def index(request):
	return HttpResponse("<h1>BnS Information Service</h1>")

#로그인 해서 소속 정보 전달.
def login(request): 
    if request.method != 'POST': 
        return HttpResponse(False)

    else:
    	data = request.body.decode("utf-8")
    	receivedData = json.loads(data)

    	receivedName = receivedData['characterName']
    	retValue = {}

    	character = Character.objects.filter(name=receivedName)
    	for i in range(0, character.count()):
    		team = Team.objects.get(teamNum=character[i].teamNum)
    		teamDungeonType = Dungeon.objects.get(dType=team.dType)
    		retValue[character[i].teamNum] = [teamDungeonType.dType, team.teamLeader]

    	return JsonResponse(retValue, safe=False)

#팀 선택하면 역할 전달.
def getRoleNum(request):
	if request.method != 'POST':
		return HttpResponse(False)

	else:
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		tactics = Tactics.objects.get(teamNum=receivedData['teamNum'], cName=receivedData['characterName'], dType=receivedData['dType'])
		role = {tactics.namedNum : tactics.role}

		return JsonResponse(role, safe=False)

#팀 추가, 삭제
def Team(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		retValue = {}

		Leader = receivedData['teamLeader']
		DungeonType = receivedData['dType']

		hashKey = str(Leader) + str(DungeonType) + str(time.time())
		teamNumber = hashlib.md5(hashKey.encode("utf-8")).hexdigest()
		print(teamNumber)
		newTeam = Team.objects.create(teamLeader=Leader,
			teamNum=teamNumber,
			dType=DungeonType)
                
		retValue['teamNumber'] = teamNumber

		return JsonResponse(retValue, safe=False)

	elif request.method == 'DELETE':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		teamNumber = receivedData['teamNum']

		Team.objects.filter(teamNum=teamNumber).delete()
		Tactics.objects.filter(teamNum=teamNumber).delete()
		Character.objects.filter(teamNum=teamNumber).delete()

		return HttpResponse(True)

	else:
		return HttpResponse(False)

#멤버 추가, 삭제
def Member(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		characterName = receivedData['characterName']
		teamNumber = receivedData['teamNumber']
		cRole = receivedData['role']
		DungeonType = receivedData['dType']
		namedNumber = receivedData['namedNum']

		newCharacter = Character.objects.update_or_create(
			name=characterName,
			teamNum=teamNumber)

		newRole = Tactics.objects.create(
			cName=characterName,
			teamNum=teamNumber,
			role=cRole,
			dType=DungeonType,
			namedNum=namedNumber)

	elif request.method == 'DELETE':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		characterName = receivedData['characterName']
		teamNumber = receivedData['teamNumber']

		Character.objects.filter(teamNum=teamNumber, name=characterName).delete()
		Tactics.objects.filter(teamNum=teamNumber, cName=characterName).delete()

		return HttpResponse(True)

	else:
		return HttpResponse(False)

#멤버 역할 수정
def modifyRole(request):
	if request.method != 'POST':
		return HttpResponse(False)

	else:
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		teamNumber = receivedData['teamNum']
		characterName = receivedData['characterName']
		DungeonType = receivedData['dType']
		newRole = receivedData['role']
		namedNumber = receivedData['namedNumber']

		Tactics.objects.filter(teamNum=teamNumber, cName=characterName, namedNum=namedNumber, dType=DungeonType).update(role=newRole)

		return HttpResponse(True)

#팀 멤버 목록 받아오기
def getMemberList(request):
	if request.method != 'POST':
		return HttpResponse(False)

	else:
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		receivedTeamNum = receivedData['teamNum']
		retValue = {}

		character = Character.objects.filter(teamNum=receivedTeamNum)
		for i in range(0, character.count()):
			retValue[i] = character[i].name

		return JsonResponse(retValue)
























