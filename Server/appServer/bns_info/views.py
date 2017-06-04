from django.shortcuts import render
from django.http import HttpResponse
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
		character = Character.objects.filter(name=receivedName)
		team = Team.objects.filter(teamNum=character['teamNum'])
		teamDungeonType = Dungeon.objects.filter(dType=team['dType'])

		temp = {character['teamNum']:teamDungeonType['dType']}

		retValue = json.dump(temp)
		return HttpResponse(retValue)
		
	else:
		return HttpResponse('Request is not POST method.')

#팀 선택하면 역할 전달.
def getRoleNum(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		tactics = Tactics.objects.filter(teamNum=receivedData['teamNum'], cName=receivedData['cName'], dType=receivedData['dType'])
		role = {tactics['namedNum']:tactics['role']}

		retValue = json.dump(role)
		return HttpResponse(retValue)

	else:
		return HttpResponse('Request is not POST method.')
'''
#팀 생성
def setTeam(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		teamLeader = receivedData['teamLeader']
		teamDungeonType = receivedData['dType']

		teamNumber = hashlib.md5()
		hashKey = teamLeader + teamDungeonType + time.time()
		teamNumber.update(hashKey)









def setTeamMember(request):
	if request.method == 'POST':
		data = request.body.decode("utf-8")
		receivedData = json.loads(data)

		characterName = receivedData['characterName']
		teamNumber = receivedData['teamNumber']
		teamLeader = receivedData['teamLeader']
		
		if 


	else:
		return HttpResponse('error')

'''
		

























