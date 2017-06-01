from django.db import models
from django.utils import timezone
# Create your models here.
import json

class Character(models.Model):
    name = models.TextField(blank=True, null=True)
    teamnum = models.IntegerField(db_column='teamNum', blank=True, null=True)  # Field name made lowercase.
    id = models.IntegerField(blank=True, primary_key=True)

    class Meta:
        db_table = 'Character'


class Dungeon(models.Model):
    dtype = models.IntegerField(db_column='dType', blank=True, null=True)  # Field name made lowercase.
    namednum = models.IntegerField(db_column='namedNum', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        db_table = 'Dungeon'


class Tactics(models.Model):
    teamnum = models.IntegerField(db_column='teamNum', blank=True, null=True)  # Field name made lowercase.
    role = models.IntegerField(blank=True, null=True)
    cname = models.TextField(db_column='cName', blank=True, null=True)  # Field name made lowercase.
    dtype = models.IntegerField(db_column='dType', blank=True, null=True)  # Field name made lowercase.
    id = models.IntegerField(blank=True, primary_key=True)
    namednum = models.IntegerField(db_column='namedNum', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        db_table = 'Tactics'


class Team(models.Model):
    teamleader = models.TextField(db_column='teamLeader', blank=True, null=True)  # Field name made lowercase.
    teamnum = models.IntegerField(db_column='teamNum', blank=True, null=True)  # Field name made lowercase.
    dtype = models.IntegerField(db_column='dType', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        db_table = 'Team'

'''

class AuthGroup(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    name = models.CharField(unique=True, max_length=80)

    class Meta:
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)
    name = models.CharField(max_length=255)

    class Meta:
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()
    username = models.CharField(unique=True, max_length=150)

    class Meta:
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    action_time = models.DateTimeField()

    class Meta:
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        db_table = 'django_session'

'''
