# from email.policy import default
from django.db import models
from django.core.validators import FileExtensionValidator

# # Create your models here.


# metal_choice = [
#         ('Gold','Gold'),
#         ('Silver','Silver'),
#     ]

# ornaments = ["tikkas", "earrings", "anklets", "bangles", "rings", "necklaces", "pendants", "toe rings", "bracelets", "nose pins"]
# ornament_choice = []
# for orn in ornaments:
#     ornament_choice.append((orn, orn))


# class Account(models.Model):
#     select_metal = models.CharField(max_length=15,default='Select',choices=metal_choice)
#     ornament_type = models.CharField(max_length=15,default='Select',choices=ornament_choice)
#     purity = models.DecimalField(max_digits = 5, decimal_places = 2)

#     def __str__(self):
#         return str(self.select_metal)


class User(models.Model):
    type = models.CharField(max_length=50)
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    fullname = models.CharField(max_length=50)
    companyname = models.CharField(max_length=50)
    phone = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    branch = models.CharField(max_length=50)
    agent = models.CharField(max_length=50)
    active = models.CharField(max_length=50)
    date = models.CharField(max_length=50)

    class Meta:
        managed = True
        db_table = 'user'


class Group(models.Model):
    group_name = models.CharField(max_length=50)

    class Meta:
        managed = True
        db_table = 'group'


class Noti(models.Model):
    product_name = models.CharField(max_length=50)
    metal = models.CharField(max_length=30)
    ornament = models.CharField(max_length=100)
    purity = models.CharField(max_length=10)
    rate = models.CharField(max_length=60)
    grossw = models.CharField(db_column='grossW', max_length=100)  # Field name made lowercase.
    stonew = models.CharField(db_column='stoneW', max_length=120)  # Field name made lowercase.
    makingc = models.CharField(db_column='makingC', max_length=120)  # Field name made lowercase.
    makingcamt = models.CharField(max_length=120)
    wastagec = models.CharField(db_column='wastageC', max_length=120)  # Field name made lowercase.
    wastagecamt = models.CharField(max_length=120)
    stonec = models.CharField(db_column='stoneC', max_length=150)  # Field name made lowercase.
    netw = models.CharField(db_column='netW', max_length=120)  # Field name made lowercase.
    neta = models.CharField(db_column='NetA', max_length=160)  # Field name made lowercase.
    totala = models.CharField(db_column='totalA', max_length=160)  # Field name made lowercase.
    vaildd = models.CharField(db_column='vaildD', max_length=100)  # Field name made lowercase.
    qty = models.CharField(max_length=120)
    vendor = models.CharField(max_length=180)
    vendor_id = models.CharField(max_length=50)
    submitdate = models.CharField(db_column='submitDate', max_length=100)  # Field name made lowercase.
    image = models.CharField(max_length=320, blank=True, null=True)
    status = models.CharField(max_length=80)

    class Meta:
        managed = True
        db_table = 'noti'


# class Pics(models.Model):
#     vendor = models.CharField(max_length=150)
#     ornament = models.CharField(max_length=150)
#     model1 = models.CharField(max_length=255)
#     model2 = models.CharField(max_length=255)
#     video = models.CharField(max_length=255)
#     pic1 = models.CharField(max_length=255)
#     pic2 = models.CharField(max_length=255)
#     pic3 = models.CharField(max_length=255)
#     time = models.CharField(max_length=100)
#     date = models.CharField(max_length=100)
#     status = models.CharField(max_length=100)
#     photographer_id = models.CharField(max_length=50)

#     class Meta:
#         managed = True
#         db_table = 'pics'


class Pics2(models.Model):
    vendor = models.CharField(max_length=150)
    vendor_id = models.CharField(max_length=50)
    ornament = models.CharField(max_length=150)
    model1 = models.ImageField(upload_to='images_uploaded',null=True)
    model2 = models.ImageField(upload_to='images_uploaded',null=True)
    video = models.FileField(upload_to='videos_uploaded',null=True, validators=[FileExtensionValidator(allowed_extensions=['MOV','avi','mp4','webm','mkv'])])
    pic1 = models.ImageField(upload_to='images_uploaded',null=True)
    pic2 = models.ImageField(upload_to='images_uploaded',null=True)
    pic3 = models.ImageField(upload_to='images_uploaded',null=True)
    time = models.CharField(max_length=50)
    date = models.CharField(max_length=50)
    status = models.CharField(max_length=100)
    photographer_id = models.CharField(max_length=50)

    class Meta:
        managed = True
        db_table = 'pics2'




class Gold(models.Model):
    metal = models.CharField(max_length=150)
    rate = models.CharField(max_length=150)
    vendor = models.CharField(max_length=150)
    vendor_id = models.CharField(max_length=50)
    time = models.CharField(max_length=50)
    date = models.CharField(max_length=50)

    class Meta:
        managed = True
        db_table = 'gold'


class GoldDetail(models.Model):
    hall_mark =  models.CharField(max_length=150)
    net_weight =  models.CharField(max_length=150)
    gross_weight =  models.CharField(max_length=150)
    hall_mark_print =  models.CharField(max_length=150)
    pack_916 = models.CharField(max_length=150)
    product_id = models.CharField(max_length=150)

    class Meta:
        managed = True
        db_table = 'gold_detail'
