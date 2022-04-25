GDPC                                                                                        $   L   res://.godot/imported/brickfloor.png-bab1cbace80ab627972eea565951db9e.ctex  `      �      �o�j��T'��+��7    H   res://.godot/imported/charwalk.png-a9f067962a6454cc2f52a6e82832cbc5.ctex +            U�m�:MI>���Ѻ�Z    L   res://.godot/imported/explosion.png-730076d88b39dbfd5c22ad71f1135b01.ctex   A      �
      ������篧2�0
    D   res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex��      �      �~�n%U�4�	k�%v�    X   res://.godot/imported/index.apple-touch-icon.png-501548209163ccca221df4fc6a7c3c2a.ctex  `^      6      wM��ӥ(�5�����S9    L   res://.godot/imported/index.icon.png-86cfb60f248dbbcbb938966694a6fe5d.ctex  ��      �      �~�n%U�4�	k�%v�    H   res://.godot/imported/index.png-598db4bc1a486d88543275db98553c06.ctex   p�      (-      ,e�) � �ي��    P   res://.godot/imported/montserrat.otf-0d875bde8933edfaf65407b0d9da84e5.fontdata  ��      ��      2��=>�9MСl    H   res://.godot/imported/rock_bit.png-cd30ec3dce7edf848ee632b29d4d0c95.ctex��     �       ��ʄ���/��!7�p�       res://.godot/uid_cache.bin  ��     �      ~G��7	������(�       res://bomb.gd           }      ȧh��i����He;~       res://bomb.tscn �      �      ����Z	玛T~Ɠ�       res://bomb_spawner.gd   0      '      �F�������[�;�8       res://brickfloor.png.import @(      �      
���� zw�U85	       res://charwalk.png.import   @>      �      <�`��n}A;<��mǭ       res://explosion.png.import  �K      �      ���o1XІ+U��Z��T       res://gamestate.gd  �N      �      �Os�6N/�Fy0��}    ,   res://html/index.apple-touch-icon.png.importp�            3��v<�}��3e��        res://html/index.icon.png.import��      �      �;������Z��0       res://html/index.png.import ��      �      ����������;X���       res://icon.png   �     �      �MK;i̓Y��{*�Y       res://icon.png.import   ��      �      �WӘhV���8
ʅ�       res://lobby.gd  P�      �      :����@�M:-J�:K/       res://lobby.tscn �      �      E�"Ɓ
I42��X%R��       res://montserrat.otf.import �     �      ʰ�~B�n�O��h��Yd       res://player.gd ��     U      �g��]�6|V�n�����       res://player.tscn   ��     �      �e�Ͻ�� ���\�       res://player_controls.gd��     U      ��#�ˈ���vY       res://project.binary��           ��@�2ʩ�߂�U �B       res://rock.gd    �     �       �晋����Y�����g       res://rock.tscn ��     0      J3��f�!�x�h��f�       res://rock_bit.png.import   P�     �      θ� �^��,g�rl�P4       res://score.gd   �     a      JS�q�������"X�       res://tile_scene.tscn   ��     �      	+L��C-ֈ�i�L>�       res://tileset.tres  `�     �      2��~l��a����OF[,       res://world.tscn`�     �7      ����؇�|7�V-��    �Bmextends Area2D

var in_area = []
var from_player
var ack

func _ready(): 
	#print(is_multiplayer_authority())
	#print("bomb ack:" + str(ack))
	pass

# Called from the animation.
func explode():
	if not is_multiplayer_authority():
		# Explode only on authority.
		return
	for p in in_area:
		if p.has_method("exploded"):
			# Exploded can only be called by the authority, but will also be called locally.
			p.rpc(&"exploded", from_player)


func done():
	if is_multiplayer_authority():
		queue_free()


func _on_bomb_body_enter(body):
	if not body in in_area:
		in_area.append(body)


func _on_bomb_body_exit(body):
	in_area.erase(body)
��[gd_scene load_steps=10 format=3 uid="uid://enwoaqi0rnei"]

[ext_resource type="Script" path="res://bomb.gd" id="1"]
[ext_resource type="Texture2D" uid="uid://bdomqql6y50po" path="res://brickfloor.png" id="2"]
[ext_resource type="Texture2D" uid="uid://drfbkdqmj0gu2" path="res://explosion.png" id="3"]

[sub_resource type="RectangleShape2D" id="1"]
size = Vector2(16, 192)

[sub_resource type="RectangleShape2D" id="2"]
size = Vector2(192, 16)

[sub_resource type="Curve" id="3"]
max_value = 2.0
_data = [Vector2(0.00150494, 0.398437), 0.0, 0.0, 0, 0, Vector2(0.0152287, 1.42969), 0.0, 0.0, 0, 0, Vector2(0.478607, 1.30078), 0.0, 0.0, 0, 0, Vector2(1, 0.291016), 0.0, 0.0, 0, 0]

[sub_resource type="CurveTexture" id="4"]
curve = SubResource( "3" )

[sub_resource type="ParticlesMaterial" id="5"]
emission_shape = 2
emission_box_extents = Vector3(1, 1, 1)
gravity = Vector3(0, 0, 0)
scale_curve = SubResource( "4" )

[sub_resource type="Animation" id="6"]
length = 4.0
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("Sprite:self_modulate")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0, 0.4, 0.6, 0.8, 1.1, 1.3, 1.5, 1.8, 1.9, 2, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 3),
"transitions": PackedFloat32Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
"update": 0,
"values": [Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(8, 8, 8, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(8, 8, 8, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(8, 8, 8, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(8, 8, 8, 1), Color(1, 1, 1, 1), Color(8, 8, 8, 1), Color(1, 1, 1, 1), Color(8, 8, 8, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 0)]
}
tracks/1/type = "method"
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/path = NodePath(".")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/keys = {
"times": PackedFloat32Array(2.8, 3.4),
"transitions": PackedFloat32Array(1, 1),
"values": [{
"args": [],
"method": &"explode"
}, {
"args": [],
"method": &"done"
}]
}
tracks/2/type = "value"
tracks/2/imported = false
tracks/2/enabled = true
tracks/2/path = NodePath("Explosion1:emitting")
tracks/2/interp = 1
tracks/2/loop_wrap = true
tracks/2/keys = {
"times": PackedFloat32Array(0, 2.8),
"transitions": PackedFloat32Array(1, 1),
"update": 1,
"values": [false, true]
}
tracks/3/type = "value"
tracks/3/imported = false
tracks/3/enabled = true
tracks/3/path = NodePath("Explosion2:emitting")
tracks/3/interp = 1
tracks/3/loop_wrap = true
tracks/3/keys = {
"times": PackedFloat32Array(0, 2.8),
"transitions": PackedFloat32Array(1, 1),
"update": 1,
"values": [false, true]
}

[node name="Bomb" type="Area2D"]
monitorable = false
script = ExtResource( "1" )

[node name="Sprite" type="Sprite2D" parent="."]
position = Vector2(-2.92606, -2.92606)
texture = ExtResource( "2" )
region_enabled = true
region_rect = Rect2(144, 0, 48, 48)

[node name="Shape1" type="CollisionShape2D" parent="."]
shape = SubResource( "1" )

[node name="Shape2" type="CollisionShape2D" parent="."]
shape = SubResource( "2" )

[node name="Explosion1" type="GPUParticles2D" parent="."]
emitting = false
lifetime = 0.5
one_shot = true
explosiveness = 0.95
process_material = SubResource( "5" )
texture = ExtResource( "3" )

[node name="Explosion2" type="GPUParticles2D" parent="."]
rotation = 1.57162
emitting = false
one_shot = true
explosiveness = 0.95
process_material = SubResource( "5" )
texture = ExtResource( "3" )

[node name="AnimationPlayer" type="AnimationPlayer" parent="."]
autoplay = "anim"
anims/anim = SubResource( "6" )

[connection signal="body_entered" from="." to="." method="_on_bomb_body_enter"]
[connection signal="body_exited" from="." to="." method="_on_bomb_body_exit"]
extends MultiplayerSpawner

func _spawn_custom(data):
	if data.size() != 3 or typeof(data[0]) != TYPE_VECTOR2 or typeof(data[1]) != TYPE_INT:
		return null
	var bomb = preload("res://bomb.tscn").instantiate()
	bomb.position = data[0]
	bomb.from_player = data[1]
	bomb.ack = data[2]
	return bomb
�ah��Ց��GST2   �   0      ����               � 0        �  WEBPRIFF�  WEBPVP8L�  /���(hۆ��x$"���o�$�S2�X0H����ڶ����c+�=���!e��d�l�?�%""��7	�$ɶ�{��U�W�ZH8s.�8�$I�<a�%��8�GQ+�l�M�~#��d��n�(9����%I�$I�-bu���������~�e�
3@zd��$��$H���SX<���)�m$9�Ĩ�����Y�?C��6J�c�{%m��Fҧ�I1s���V�u�������WC�>�4o����j�+�ӱ��4�fR۶��-!P���|�#�ZҶ	���Ww��m-[6��krMnM�݂;$'�K�H��%Xww��k{���f�N�C�$g��Hʻ��͝�!g���� ���=�wכ���S]]CplkO��?�K^pJ��0�0�TX�Jʋ�^8�m�Vz�C����iJ��G ؤv�v�m{�m۶m�6/۶m�� ���HrT-��������������o����[  ���3 ���*����p�k��=�*�@���A� #���y=�!���Ȩ��UUi\�Mx��z�U��h�gݺ��Յ����s}]���t����U���G�zoiLAh�������w@��i���	��F��{�-������{2��THci�ҕ+�r,�)�6$9ټ��e�h��P�!x��=�y* �h�@�@� �fV�t��E a�,6�Q`d��	Ԭ
DO���Q��0�����R3��B3�"�QjrS^a�P0�-WU�x�+�����u>  ��@N 1zQX�E� �Q���Č���v�\!F�S��Z��0 Yҩ������k��*��h�JQ���Nr~�G�Rn1s@0% �[p^,�a���p�3\ @�~�0[�%
���q�F(�����NcË�+�Ǩ�-p����dS�  ��/���[YMX �IJ�|=G+��=^0)�F��8��&A#�O�y��a����z�� �������q��S��(��������v���Y~�~3����pˮ*�xQ@@��AԬŠخ6!�[����^�3Uߊ�"���i,�+�'�R����6̭R:�g'Ga1�ZN�/�x15 
 /R���X`�sǜ; ����ۥ�����r��� ���ti�u�'qg��A�ڒ��,Y��c 6�X�^ ����JұH���R &9���rN��0��K�' �B�~q�=8�d�a#G�# �'(,  �ۥ��@zD�Z!���bT��
A0z���azÈ�Xމ���Y`���
���l)0�3[�0>(fN S 8[��[Ӳp� _d�0H��/�O�ܬ��Ɯk�]�o_.�S�o����XR6K�%F�
�q�h'`*`�ӫEİ4D/��r&u�0�/-]�M���Jj�3!&M�$��Lsn����5ie���	�j���a��B	�.�#f�o�r�۲]�4�N��Zk��b�X#3V/��K�~XhH�^ ����ˋ7/e�!�������d�Uq���[���8b��U�U( �66с�  �?�w�}��$^�Crb��$���R-��lh�V��al�z�!�0@hH���.C<WV+���ST��3[�:��*���Re��Ssޥ�%@�Ha���0��O��8�TC��Į�I���K��"����"Ѱ���A�J�h�ji�0ا~@�@8���M�K�z�
q 8�iҴ��x��'(�Q��-��t~r8Q]��B
� @x�vߡ��l�C\=���C�u���aI(��b];7׷qݰ*1KԂ &�B�P1���@�~��Z@�xy¡���N��R�htf�w0�6s̜� �E��RJ<@� � �@��,�����C Qg ;�C�k{�Nt���#)y��Z�2}i�s�4zG�j�	Ț)[4�RF;�2S=� ����z �JeE�Nb��d�4���yt)�f1�+�	C�ry���Ex�$���&�� �`q��� Z  |	$؂�����du�Dg,
�����d��T*ْ�&����F��@Kl�Q CCl�4<�h�0- ���6�4<����J�F9[ki5B��d)��$M:E��c]�H�,�Rhc���Eh#؄�)
z@fh�/WX�����Q��FYb��Mu�1^zP/�Z-���0���N Oy�b���z�S��F!�W0:(�l	��qQ�IĜ ��d�  �@��@әF!�D�� Xh�/חpߩ�S J�Q�H;f'6� �z""������4�"L/�XM5MQ��ce5oUÀQƪ��1�="[���1Y��� W�f��G @��^�<A�B������7fU=� ��Yo�  <�j���En�oS$���%�	4K!F��ҋ� �jiz�  �d��Ȩ�\�TI��`�:%�Yz�k;gU]_u�a���+w�d��!��3x���  "?,�ĭ�,ph��թ���o^�Y=1�۸.#��~4|�{S���COL��wK��'F�<  4�XC,�%���B�1��;Fo@��K�W��1�;�]d��:�vV@�c�[���q4h������8o-�{D."��GȠ�4@����HYP�2�o�gj��r�ł�~M���J��c �V��Tj'�R����	��T*�0�@0z0���G �I�|��z���(�g�\3�8F)�٪�âEq@����B�Ax}-B�A؀��&��P���M÷���]Ft�z��7��4(�6���� �G<5��?xn�/ F�ӄ�e5�NG�s ��p#R�<���at?s�
�Ӏ����*Tp��& 
N��P|��6l���r}	��I�����)?������Leʩ%���\J�(�0#�$��TB�Ng�	��\%�
�=. h�� � Hy8�-��V����w�����' p� )w�j��ҝ*��Mu#rt���D.G�7.�$�ׁ1�� {[���xh�.��gp�9� ��!TǃB8������7 �:S�]��2�ƕ���Չ�0	��(-��T· �E�/}n"�>4���%�.�0d�5d�������2�q�'y�ήp�a.�a�9o�z�܋���*��:�m7m�K��V�%�)�) 1P4r���A"<C��b�`0����S���x � ��(X��UsV��bz&M)%��4�OJ�B>U��(��
�O�/<f��5f��  	�CL<�ؗ�G��EL�2�hLKDH�҈Y51���a � ]�E+Ӆ1*��I���=�5y�Qgl;qL�C�ԉm����61�� $0 %@� �Ń���cS̡t	`#& %�K���1��4� �>p�}\��n�ɕ�d�2'��2@��R:�/��C�9 ��?X% �D��Kd�  (( �#�oȀ�x�"�w|�(5���P�^���B�1`i��bA��CC�y�QIQ�H9��y٭A4LUĜ�	��KM.�E�}��D
�nb�� )�Y�  
] 0A�]|�/!/PW����Q�3� �#)b�2b�Z` P;0���c�v�.(e�ЕD�L�('fQ��陭_�L�*-N NbJ�o�7��1�`	,�@g `Q�K� �q@�B�ă(��Fq4R�F��%�QBS4��v�A-Y냫�y�"�F�L��皘�x��L�x2�t������ ����
�/,�/h�[�B���&>��> � �U��*`g�P0�^�iX�6Kqa4��A����(����K��U��E~\�IM5ZYDz���l"[�'9�0Ƶ<����>&P�5',�i]<�CH��5먣 Ѕ` ې5�!�;��vO�E2<m�1 ��,���Q���lb�X���x4����uN�cì�4�*���a�f �мN��'ㄌ����؃�@�$����� %����:���v�2D	�(�@�`ʪ�Ɉ%1 �����4�>�vT	�FOr�b�i�̜�)�5��ҹ�Z&���1 ������^9  mw��sQ-��	.tB�؂
�V��4(R�	��"�b��jɐ�Z�N���wl��1  �s�>R�`�ܕ�PD0z�l�iMИr59�ٹ�@��G����H��X$HP��(�m؎�s��C;3'U�k��}����YK��DVQh�YB�f+��֔U/�E06��Z�7�
����U�a�J�٢�(�F�W����
������d'�y���1���b� ?�(f 氎�?� ���~-��F�ک� y
���m�A'{iZUjD��HZՂaz1<���h��-�Jj�4U�,s@��6o{�4F�j<�nt.0ۓ<)�>:�� 2Tha�`���P�r��tG�Іh,͇���tEwL�X׶%V�r�V�k[��b(����W/�h������@� �u$�'��;w�S��f �mtrd
���3���#�8�Tx �f��
���ǥ4L�ltm��E��(���6��P�*Yʤf	�U6K�LP� G�@/��W����Ec}h�2_��S�bTV��ss����3
3@h&��6���	^��˘ ,c ��/h���� �a�h��G�X�6�i�>�O��tβ�7}�s��D*� �UV��5Z#�bi��T��Ȕ�!h�v���-�'��tN5�<���%��`���=WF�da�9�9��3�2J�������&�󋍐`�P��0���A�>@wp�١&��������g��.%K�r�\��h	��ސ�DQ��
P��U K�F�=��h�7Q-�)�2)���Q1y�#�����'O��8�I�^'�71y�iǼ ˰��fP3�T ����n�I<N��7�5���vd���$y)���#g�<�I�/ݰ*��I3@�F�j�C"H#���F���7�b��CO!�Fu�Ul[P�Dd��sN���'y�>we�3�P�tlM�e�>��.�s   Ѓ�p5�
2��	���O���ȫIĽ��B���*y���jo��� 314Sm�$�vZ3B6,1���dM�L/�AŠ�%��e���h�:`.�nي'�rl��)L�c�a�2P~�� �!���@�V�� 2� ����R�1Vc�Cz���\�I��r�����Tu�vz��c-�w��  �ne�\?��a�������=z5�E����b�'W��q��$x ?�:��]���1  (�RȋH��g<�-��(������d��F�$����1h�EJ%d+��X�-�x��.����������%%�Y��|x?����+�E,(
  ʧr��  6�@�& �n[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bdomqql6y50po"
path="res://.godot/imported/brickfloor.png-bab1cbace80ab627972eea565951db9e.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://brickfloor.png"
dest_files=["res://.godot/imported/brickfloor.png-bab1cbace80ab627972eea565951db9e.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
��U./z	t4vFGST2   �   �      ����               � �        �  WEBPRIFF�  WEBPVP8L�  /��/��&�dU��2��9x}��m��$������s�S�Vt�`ǒ Ol<��-���-�_oLm>���,�z� ]v�>�� ��x�}���e 8�$���mx�m��m۶�"�^�Ԏ����Rdlm��
!��$I�f��qv�����օ��!����!����ݘ����v�k�����F�����z�A�H#䒨.���&V��&ȵ�
Ű�k-<gxR���8�y�*QRH���a��*��8i�AR�
G�v5�)� �ɱ*=��K�5b��$<�C�b�\���n��Q ��U���X��:�T|�(���
�
��&�I]6��*0�d��!�!5l�2�(H�E�ZWM ������XK
��-�
(%�e5���nQq/c/T����@XM�&��P��=�g�	�����ͺ��K������H�
��D�!QK��E��^�YB�5~�N�#�
���.��Å
���raT�lyn�@�a�ΫɅ#0�r��������g�8��"G?ec	l�ތ.�������\'��Z5��[��o�&��<+"|^(�h�:�̹K����BEi���u��Ie��|���	+��"� 1�Y\
k2m�=7)4��Zp����g���=f̄}��*iz�P��b���yif��\l:!"�=)�ـ���L��C�<aJ�����^8������t�P&��J�$M��|�'�}���)}����E.�d���L���)�%��ןi���eN�t"'J��̉3m����-	��D�y���*�2�������d���:�^LɥK�% �^(���)s�d���=
JN3�,�rN)p$�)Q'\�;(g����4�c�60�X��3Fp$��_)S9w8�w"���<��Y�̵��.�G����){A*���)*�;�̅�ʰ�+�˃�ݭK��4�]z��vZ��WE�^�����3Q�E�<4h�V�c��\a0��^c�."漏��1#jc�f��{�x��h1�3:�쫩����^}&��}��kk�Tl���`��L��ьV�5�y�����>����J�1���6z�/pr�=}�{*��ӌW{F�B�����)i�h�x��5lM�xm͛Rf�}ۉ��`>�y�yO�&�IzZcr_0�ٖ�=1�y&w������j�p��[/�j5�_�}<����_S�^�魵���׎3O��p�����[{M|�c����z���?�x�r��Mops6�=�zͨ�p�^�]�s�v�Γm#</{�_?�����W�����<=�N��q��^L,��x����
U��n���.�^����iĵW����ַ�]��-M~7�7}�כj�C!�Du	ԇ4��4A��W(�%]k�9Ó*��aΫT��BJUu[�V|�Ik��T8j��AN�8�`N�U��\r8���D'���;��u�}�"  M�jTw�jo���D���V�T �69L꺰�hT�'�\�a#�DAR.bֺj؆8g �Hu.�ZR��h�V@)��(�Y5�v#���x[x٠
4��jj6��m���98<�N��䴟n���\w�%�hD�U@l� ��rX*��,:P�������wjAVؘ�7v1��'\�P@��W���g�s�b�t^M.��K�`'(��H�\���8�Q�9*�)K`��ft��(Uf0=w��:Y��Gժ�g݂Dx5�'�Y��B��E�թg�]
�uN*�H;\u�[\L*�P��lLX9D���y��RX�i��I�q4ւ��T>�HL���1c&웬VI�k��He6�K3��b�	��Ia��ϔg����	S����D�/Ǉ��2��T�'i���=I��[�L���ן/�p�%��8Td275��H!�`H.����ᯯ�\ (sʦ9Q�&gN�i��~�lI(��&���d�W`������%����1 �bJ.]J.��B!�M�3%��\8���QPrB�!fI�sJ�#��M�:���A9��妹{���Ģ\�1�#�\��J�ʹ�ɾAN>7�9�(�"f�U��w=������L�R�ܯHQ����d.DV��\�\(���֥�m��.��9-�K̫"l��T� ��3Q�E�<4h����e�0��N���EĜ�>�߂��\�wg�"P�14a�b�)���n�(�yF��V��G5:^[w������G3Rm��JޅKJ4F����꣏1����z�v�R*��ry�РMo�~M����G׌�y����'}B/|�L��s�>�n.�J�m���<�/_�=�һ�?cD^���s��̛!}�����5���Y��e�3�UTN�o�et�fM/˽��& ��F/oa���F����f�Tt�[��S��m�v/�MN>_�yQαמ���?lN��)�;�~����VօԾY��.H��������%��l���כ9A�o��qj�w"��0^��u��r�=-�~H#��z7&>���]�ڭoi�Q�!����dP���$�K��>���|�	r-�B1,�Z��T��8s^�J�R��sت���#NZk�T��Q�]r��9/ sr�J`��9E��%:	����!��`���k irU��3V;x�N/_$�}����!��aRׅĨ@�
�8�E�z�`H�� 
�r��U�6�9�E�s9֒.�@˵J�$EYͪ�AT�����U ��>VS��Do#5x���Yw,$��t�����k�(1�@#�b3}H��R�gс���w��t���S���Ƭ������8᪇콪\�>[�/s��jr���\bt ;A�$Fb�B�D���8����Q�O�X�7��4F�2���Ǩ ��"�<�VM=�, ���?1ϊ���,��N=s�R0�sz�P�G��k��bR�2_0fc��!�H�&H�s�L�e�M
����&h��Eb�,u�3a�d�J�^;TgE�X(�q^��60�N�HlO
s6 }�<S���'O���`�`��$b}9>4?�ɥ���?I�}&�I�d�j(gJ_���|фK.Y�ġ"������D
ACrɅ'��gZ�� A�S6�ȉR69s�L[���{fKB��4�@^'��� {��'���g.�$����Sr�Rr	��
)�lʜ)�E��9�t����1K��S
	�n��D�S��Y(�/7��سL'���	���W�T�N��r�ϡFy1s��������Ǆdf�^�
o�~E�J�'s!�2,�
��bw���6�y��n��q�yU���
��m0e[Ḍ�A�6k�>F��(�5F�"b���k3rP�6Fo��<Q�������3?�Sa�Ͼ��?�h���g�>���g�6M�F��&J��Z�h��[��7���O�#��
9��c؟k���'����G����m<�x�g4.{��m������W�^���j���м)e6ܷ���泙7q���i�����5&��my��gr^h�y���˸�"�VS��E����3��8�5��5��Z��Xz��1����_�]�����>�ͽ���{�����/���7g����׌���u�u;�j��<�6��W�E�#��p
{�x�	����cу���7h���"~�׻n?�P������B��{Zx��F\{�nL|nk}�ڵ[���w�~C��y�ɠ�?�rIT��A}H+��J�Zx�bXҵ�3<�R�q�J�()�TU�Uk�G��� �H��F���s^ ��X���%�s��Kt�!k�C.��\���( ��Fug�v��^*�H	�PmIBl�ä��Q�Fq2�����6b�A$�"f��&�m�s��T�r�%\ꁖk�I���U�i7��8������@@�} ��f��F(j�ó�XHN��f]��%p�|Qbl�F$Z�f
"��(��B΢uq/�,��?}��d��Y}cc�q�U�{U�0�}�<7^ �0J����A��� v�rI��ȅp�z��quo������6^oF�i�Re�s��QA��E�yT��z�-X@�7Pb�>/��Y4Y�z�ܥ`^��P�����U׺�Ť2�e�`�Ƅ�CT�
M���,.�5�6˞�Gc-8M�L�3��tY�3f¾�j�4�v�ΊT�Pf�4�m`.6��؞�l@�Ly����O�0%��z�X/I��r|h:~(�K	A%���L>ړ�ɾ�PΔ�~}���	�\�؉CE&sS������O��ϴL�u�2�l:��lr�ę�����̖�r�i"n��Nf{��^�O��M��\2IJYP/��ҥ�O/R~ٔ9S2�ȅs��%'�b�D9�8��׉(����PN_n�˱g�N,��#8�ŏ����;��;��s�C��,b�Ze��#�o	�	�̔� �������N�BdeX�����UZ���iλ�v�v�Ÿļ*���HOֈ6���-"���Y@Рͳ��gs��D�轋�9���	:�����<؆i�0s�Җ�a@b�y�}j=��w$��^�G��q`I-�M�*6z/���ɥ�>��j�)��ot榧�Cv�fi�G�y�S���u��d��x�*����%7FO���)ۈvnzԬw��j�z7~�ϝF�m�Z�<�}�����)my)���^��^���4�p����S�7cK*w탆<��5��z�S[0�A�s�[1^�5}M��һ6�p�K^�����
\�q+��e�5���[��W�;�D�Zc���ʙ��{0�ֈ��)��l��m�U��:_z�MF��W8�
����|�녴�W8cLM�8c���Nxżъ�ڀ��7�+��ւo�z��?�� /T[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bsqovikudjr0q"
path="res://.godot/imported/charwalk.png-a9f067962a6454cc2f52a6e82832cbc5.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://charwalk.png"
dest_files=["res://.godot/imported/charwalk.png-a9f067962a6454cc2f52a6e82832cbc5.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
s}
GST2   0   0      ����               0 0        �
  WEBPRIFF~
  WEBPVP8Lr
  //��.D�?6��x�/ v�H "�LpAI��D��J��,���3�^1�^1������+G03335WCqU�ݩ��P�$I�]y��J���,<�N�ü��̻��L'I�ۖW������/��*���]�o����Qz�pΙ�D��1��_]#���m�Ҳm�g۶m�ɳ�_l[uˁ�6�$%7���>�2K��%=�h
{`���x��F1�����Gi��H�a���l�w,�=�d��@�;�'N���F[ud�]�G4���~�A�D����w>x���*(���zT1�|�g�3
� l�[  H�dx� @&� �~:xT�8D�����N7=ʯ�?�W�
��g�wY}�?�]?Ǵ�?�N���&�w/���	٫�-�����x��(�L���9�w �%�>	lE!�}ax���z�b��#'U��|Xz�'��k xa^F��K�������"*J��`�b-L��M�g�~�t���v�2k]�j���	��&bD��s�=]�35ִ�6�L�k��HY~/��@j ��o)�݋�~B �<`�  <  �B��r�t��ӎɂ��������Ip�^}��O����cgc`�P�s�r60���xT`]�M�H�G���nL2�l�ҟ)
�� ,?v�+�8���RGb	�,Xx b )����D#RL!  ӡ<�ɍ�bcd�º���  1�
   �J�8�
@�uiG�:"�r�  `_�{�FY�]�����0��ice\��J�w�9�Z�: �� @�H�����̠���fav9fGF h��nu�,ϝ�Y� � ����b  �x��  �>|^�?3�c�A���Y�� �d��(>6�D��J  �ܐ�U B2U��  �i�  @����慮NC!��ǻܲ� �ci:Y  2�����܇�o���  y�     �H�*�ʼ���NCc[} ��x�g�
p`� 4��)`(����y��;U  ��zf ����a�褣3:��� xg=i�;U80 ��6�V�N������)� ����f'��6:Y�d��v'n�4�� R�ÃA  �C�����:R�X{�t��~��X�k�-so�,hQJӸe���,  ��u�`�2Z���u��䧉��,P$<!a �hÇ��um#���8a��Բ���
 ��1D�$$J�p ���N ܁G  ����2��  �}{��^�K����u� �F�!FHd Aڲ����0�urἱ�[� �a/L�*�,Z��,��p�=�:�-t!�!����		�rF�@��N������V=M��v������c  �S�	��NV���3���+����,��n*�j��b \  �I�{��d�@�,�k��W3�Κʠ�de,;�ŬU��[<��<���3�;������0?��Ⱦ���Լ��Ehd����F�
���,�[J  ����Y(e��M�ل�cW��f���⥛/��¼�?�t��5���V�� !Lb1\�=8��a�X۷l%�4��F(4Cv=S�Z�e����������Z	 �*�;$-T`` P�+x�D��Z�����,��f��I��mA^.�_6�ˡ�_��֥�w�$�*#G�U�S<8�Qє�2�t��Vu4 ����N��?�̺�;o��қ�fԋf )!�X ��!.&3�k�<!�u۵:kt�w'1�Ј���6�t��,u��A����F���T��5f�s�����
��������e����+�4�RO3�4�b�8&��RJ ,�����~
`��e�0[�6,q�@J	 A���c��  %��i�RQ� ��ng�Sc�I��h�|ξ)� @�Z׋3#A�R#�D(A�E=M)�u�� �P�BY����^6)�_���5# @�l*^&�i2[�f�Om @c��]�I��4��Vz���*E8p 4Zf!:�X����yc��HY}�����`��#  �����><�p�/����{��_sR�&��	������ ! �A�>�R �ʢ@J(3�����q��qN��?p�ࢱtղd�m�oYR%. ��C[������0�B��-/(�o��{�༱  h��;��]S�EeHD(@#���b��;���j�'5����P��??�۟���s/
 ���}��4'g �Q:f���*\!Rb�����,�  ��KjG�l ?$  �5c�e�} ���==���<�
��.�ƒ�)�V�LȠ- qCf�|n��i�����=!��O`�[�7?=)z�e�6B�RF�J:&͎$��� B�N�>fOꭼ��?%�Ө�_�Y�����d)�8ܵ
@�n?,c���	Yio{�J�����J,�"�7ݍ&܅9�J `>|R�h)��$�%� �<��Y�{�ۓj�~Qp�B��8|O  ���������g  ������4�N�k��'��a	���Ր �.��H�M����'������a��l ~����AV�N����
A�^�+Ȃ�� �Hhi .�3pPG  x�x�+ � l�uU� `��q�/�Ve
Bk�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://drfbkdqmj0gu2"
path="res://.godot/imported/explosion.png-730076d88b39dbfd5c22ad71f1135b01.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://explosion.png"
dest_files=["res://.godot/imported/explosion.png-730076d88b39dbfd5c22ad71f1135b01.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
extends Node

# Default game server port. Can be any number between 1024 and 49151.
# Not on the list of registered or common ports as of November 2020:
# https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
const DEFAULT_PORT = 10567

# Max number of players.
const MAX_PEERS = 12

var peer = null

# Name for my player.
var player_name = "The Warrior"

# Names for remote players in id:name format.
var players = {}
var players_ready = []

# Signals to let lobby GUI know what's going on.
signal player_list_changed()
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what)

# Callback from SceneTree.
func _player_connected(id):
	# Registration of a client beings here, tell the connected player that we are here.
	rpc_id(id, StringName("register_player"), player_name)


# Callback from SceneTree.
func _player_disconnected(id):
	if has_node("/root/World"): # Game is in progress.
		if multiplayer.is_server():
			game_error.emit("Player " + players[id] + " disconnected")
			end_game()
	else: # Game is not in progress.
		# Unregister this player.
		unregister_player(id)


# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	# We just connected to a server
	connection_succeeded.emit()


# Callback from SceneTree, only for clients (not server).
func _server_disconnected():
	game_error.emit("Server disconnected")
	end_game()


# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	multiplayer.set_network_peer(null) # Remove peer
	connection_failed.emit()


# Lobby management functions.
@rpc(any_peer)
func register_player(new_player_name):
	var id = multiplayer.get_remote_sender_id()
	players[id] = new_player_name
	player_list_changed.emit()


func unregister_player(id):
	players.erase(id)
	player_list_changed.emit()


@rpc(call_local)
func load_world():
	# Change scene.
	var world = load("res://world.tscn").instantiate()
	get_tree().get_root().add_child(world)
	get_tree().get_root().get_node("Lobby").hide()

	# Set up score.
	world.get_node("Score").add_player(multiplayer.get_unique_id(), player_name)
	for pn in players:
		world.get_node("Score").add_player(pn, players[pn])
	get_tree().set_pause(false) # Unpause and unleash the game!


func host_game(new_player_name):
	player_name = new_player_name
	peer = ENetMultiplayerPeer.new()
	peer.create_server(DEFAULT_PORT, MAX_PEERS)
	multiplayer.set_multiplayer_peer(peer)


func join_game(ip, new_player_name):
	player_name = new_player_name
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, DEFAULT_PORT)
	multiplayer.set_multiplayer_peer(peer)


func get_player_list():
	return players.values()


func get_player_name():
	return player_name


func begin_game():
	assert(multiplayer.is_server())
	load_world.rpc()

	var world = get_tree().get_root().get_node("World")
	var player_scene = load("res://player.tscn")

	# Create a dictionary with peer id and respective spawn points, could be improved by randomizing.
	var spawn_points = {}
	spawn_points[1] = 0 # Server in spawn point 0.
	var spawn_point_idx = 1
	for p in players:
		spawn_points[p] = spawn_point_idx
		spawn_point_idx += 1

	for p_id in spawn_points:
		var spawn_pos = world.get_node("SpawnPoints/" + str(spawn_points[p_id])).position
		var player = player_scene.instantiate()
		player.synced_position = spawn_pos
		player.name = str(p_id)
		player.set_player_name(player_name if p_id == multiplayer.get_unique_id() else players[p_id])
		world.get_node("Players").add_child(player)


func end_game():
	if has_node("/root/World"): # Game is in progress.
		# End it
		get_node("/root/World").queue_free()

	game_ended.emit()
	players.clear()


func _ready():
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	multiplayer.connected_to_server.connect(_connected_ok)
	multiplayer.connection_failed.connect(_connected_fail)
	multiplayer.server_disconnected.connect(_server_disconnected)
`f�`M�3����GST2   �   �      ����               � �        �5  WEBPRIFF�5  WEBPVP8L�5  /��, ���'"���H�ѠPF�$)*�:���#DQ#IJ	���N �SQ$I�
 ��d��;B4�!�HP2�bE��.v�+��`O3,�AP���"�C�m�ޟ��A^���
eٶm�m��0S�����q���nQl$ɑ$��,���=�%��Hr$�ѳ�����t����=nm�����j����߽�y�JD�����jF-z�l[�$I�p�OD̢-��O��f���oI�,I�lI�3��~������Zu�0�	�m��ٶ��y^ �2$���f��g������܉A2H��@��i���mۮ$I�4���="&fE�4��7ye!��� I�j۶m�{��G�cnf޻�E���gҀ�2b��? �JE�7��B\��� Q!�.�V�% ! �PT��ڊ�j� ����:��b
|3�k Q�*EM@sQQ@i �$����
hV̤A,@��*���`�r���'�BAb�L� @b T٪ 4�����0 V]O�T�� � �RVq%� T�@*�*@�� ��p�فԀ� fcwP��r���Xs�-7�D] ��� � �� �V �� Ġp��g� ���w�f�̮=�+ ��K, "@<��f ��Za�!t2
heZ `&jOL݅��v� k��,����8����'� 0 �P��: �X���n�"w{��h���O� � �� �Ou�@]�G�` (Y: `07j%PWlu��v۞�d�Lem��=^��U@@ �  X�5ȶ��VS��X@�X�'TB`PA%� 0���f��`V�c�8�`Κk6�kdC�z�Y�iբ֪z��"�ӈ��"gU�j|O�Jr��[�*��.W�i�"�d��4�� V͙*.���@ COC����,������d�u���'����4�������HX�?�x�h��V߱8�c`��lw��&k��ڽ��׀��m��	��~F� ��9������G�T� b����6L�V,*( �����P��x��uo�j k�� �A��+�����|��5���/ۗY>���T�AӦV���gx���+4�"�1{w��/`��x\% b b�d���
@@����PW�e�@ڄ���@S�����M�Θ��4��h��SǺB�+U2 s��J "Q��)�Y] ��S �a1�B��]���SWPH��+$�
�2�"o#�A]�X�� ��+s��y@L�I�2U���9�λ{O������n@=�5UDy�h���R��S�Eg��|O�Ow	p�~}�Р���l<�f�Z�z���
0�/� ���fЫ�ص�)�H��M	�l$ z�a��z���i^�=?/A��j=�S�U[
Pc�-`�����H������gJ@O�w�k0W-}����R�Uj��h�<�k*�2n������(@��$G��	cOCfF �� �8�wyx��ty�E@�zZɚ%(��W(��޾��4���rզO3��W�P�g����V�[	h��+����TB!��$�1@��}O�,� 63DG�z2��.��T�� 1q���LQ��j �"UB�H��BMN [A���c �:@�ɠz��~��) �f8v����' 5�y8��mm��aqr 7�n $G�)�q�f+�t2�h�׶���ݶ� ��xԫ(���&ko`�U`  keCO�
 a���ʴ ����G!��- W�+�{�Y�;_1��t}* �9_,x�O�r�X��w�;� �U�_ �.R䬽�
 @�͖i�T��$ ���1 �`L��9u"�e�`d��J9s�Hn% ��5����I h4��Qm�TlT"*Pd|�1M@� ��f0�1��]E@O�/<�{��ݎ �<-@iٲ���,%� f갯 �&U _�3c��diY�ӫ�z��
0��
 �w}���VWo�s�s_�L�d0  �p���� ���˵;��{���QM@m竵oWs��̬P5��u�Zϊ��/�Yӯ�3����׍��{�0�mm	�V��b��H{�������=A�d�ј�i{�����������p�( 5���z�iUo�9�+sp9�\���$s&`�~����2k�� }��d�?���џ�����#`�aY!�P!
 B���`�1��;���
 b!T$��b@  ��H$�;c� V�*���W!vUe�$ `��$�� �PAT T٪ NPx�d�X��Eӽ�l� ��O����; g?{V}����W���5����03YC#��[z}$u��l��[[�kЏ��h;s @B ���٭r�u���j�Xgg?�M�����
��'�l�5쥆.�F�#�ܹ�V@fmS�e��Ġ�ۣ� �s@��M`U>��ժ���ə���tE.J�қ�:��,��H׍�.>��6��� NK/ �|�� ���y����u�-^�`l���Q!�Tۺ>^'�`[WM�hD1�
}�H��
��f�P�. Pʕ��=�k�V *�� u��Ъ�6̅��*��������j=�pA��:���̩ �3 2k��`L��:6@E�N��kN,��<�kx�l $ �ów�-����P��πv���;`�f��dhX+�f�l%`L��xL"��H��}�| �uQ ��֣.���=w?6�'#�v)S�
�H$S1Ĵj՞������BAT TUJ �M �U��G�"1���d&��@�#@���*��= д�ֺ���ZU���u�"ҧo!�W?#U(L Ī��fw�Yo@����U�u7��D�oр^#�
P���yp����v�;,�ݒ�Z׺�@���-��3
(�s0�)���zU��4�-/���" J���{`�L`J����pb��xt{�=@;c�/a���부�l��߻�P���jWn������;7m>� ��G�ZF6��!��P̙d~��5�����Ok�S]h��u��W� df�]������T����5Q@٬I��J���ӻ�^�������֕���q��� �ij�W��� ������*�H�>Qźr+������[BF* �.�|��&@p�[6]-�9 7n�w��� �A��2g�� ��H�j=;���g(� u ��{��T���\O���>+���暭 z7�W՜�� ]c�]䢘,�t�;���J�+��W�JI���(I�_�P�K�UE	��H���P'ọ �+����V ��S��Q�<U�z"
ޡr����{��*[]O�'1���
AUL]�0 �vO�v�����v��Mj��u���[�5��`(�!�f� �5�.24&^����A���Z^޻���|-@�`� �*TP�tϽm���O<���X�2k&��t=/zu�c��0�=F���cLt��~���6�8�`�<0�A/��{��P���5��=k��bUp�m��_@�]<pr�3@����u[�
��=�t�D}��a�s�w���i s�f�G��t���^c��ə% uL����
��7�"�4�j�I)S�z�G�t��oE#* �Y�,Јjy�JRT�V d$3k0���d�4�W�^o���;�s?� �f�.��3� ���cr���F�7Is
���aT)��b],�U��TA#o�v�U��cj�B���n��}{�k�M�93	��;��fF �`�jDޤ��T�2���jeJ���f! �T>��4�ޤ�H \�2�"@pc(���[���z��?k���+�^��Ч���__պ�,����x���U��f`Lc DH������6��'�ӷ>����YW��W�__1_��x�p���/uV4M����t��^�mLk�����WзN�__ժyU��P߮�)f�PW<�U~#�� u��o��1-�@�� ��*[S�� �"���� V]% EBWuY@Ŋ%�.��X��RU�B�b@,'�� 1u@b\1��= �%�+&��
E���Ƴ�UֺVW��d9 ��3����+h�ZƳ�c�n^Y@{�2�U{��3w@\##Q@��t��V�@m�@��ڈ�� �M*O�@�:O�&��u���3��<�=�3�Z@�n���j^��Q�ym>ƼR����6�\��{��ZF��m@���*3��*H-�k/�H� "��@C@E��U	��;�5�]�ˬ�ȕ�. �f�q���* }���Y�ЧY����;��4��( �ͮJ��:��[2@�i� �6d�T�tk����DB����ͲA�S�"@T_⮻��Ck���6�i�����D5!TR��WC�Z�u �h�R��>�8�Y]�<@�L�f{u� ��ν�I��J�*�]�� &��l���|��V��m	��g��<Ak_�W�Ц�x�8r�w~�u!v��it�� �����O����t:��3��&S��1�����ꀮ~fM��=F�WH��
�~ k2UX�V���~�׽�z�s��W03m-��W�2�xu��>k�z�j�Z�-���j_��B��`;@]�\��ݓ�W�C� D�t`>��t��ƻN q�i�n���X�e~��Ou��ZSS%��À��ړ��O`��� g̰րխ݌'�5lXPkj��k]����~�{���|�{ˀ5����.g����Yתu������\u�J88��$�\��� ��R1����=����YZ����#P0Q�P�S��@� (W�: ��T�� �6�LI�DEB@O���U,z�����
�*� [U^1��wPUe���{дf ��?�M�G��}-
����z���p|8>޺�z.�%�pww�}��������z&{;��uw���q�1� �ã��`���� v��p�� t���
�����e�M��. v���]�ȏ���z�8�Ǿw/�^��������+7�o���p����O $�"[U�*`{�~��rCȟ���w�v|l�
��)�j�zY�>M@���տ�u���u�
��#���n���r��h� ��� ��KЯ�u�i���`
���(�����+�{��
��^����>�x�u�����8������j�����O���]8�������܇��4�J M� B *0 �پھք������������T�j�u�n]о�����_�/�:����q3��{�m,��[Px*b���`�[ݪ���{ T<yf�E �z�m,��[0�����ߵ����!_��'�nǾ/ �z�������]�������?�ӋƠi06��U���皀l��=oyڴ
�.�b��W��t����
���R6π���w �Ԫ��xj0�j%�):�i����,�ڭ�| ���0�j1�]�L6���n. ��� �S�P�u��y����͏w�V��5 Bk []���ߟ?�������������������~�ۻ��{F�^��ƿ�~�'����?����h��~^�^���ѳ�d>�|�i�v>������k��4��������?�n�y�{`t�gt����_�����o`��u�����������<@���O[���w�{|���;�~����x���֯[_�_x����W�V;^��[ �o~�˿��?��c����������PQ�0R��T\�����������F�ݶDҍՍ[P�����8˼�������s�m�9����n9�z��\�z�/s�#��d�O������������l�w��_7�d�h+hs֩]L���_�W]�/��qi$О~{�>��@T���ǊZ�z]�y.�	$��X�j����뇱 �r,�}] {��}9�ڀE�6u �շ�E��C�G�@H L" *���[��&`���[�zH�T�s���ә��� LG�S "-՚H�6��rn`�)�l�����u��t��8�����������:^�P���� �L�=��� (�R�h�����%]��9۲]��U�VV���kڜ�����@;���V���Y H@fC�-� hd 1r�ۧޗ��u֤
A�~N� ����ٹ\o���z`�~vw9v�R����N�r�s���=O�9�'��<������/Y�#g_����fsr�v��GH��_յ@d�q�uF�^k���Z�\�\Ԝ��q��??3]�W[.� z�%se� Uzz	�z�9�L�3�
��P�
 �g�wn��ޟ����ף��x�pN����X<r��|�_��������a�z��a=KoH�c��tހ������m�-�r�y���J0��}�i}���]ֶ���yf�d��_2l�Z{o��Z��iާ��p>5y������ 7O�������3�77?��7�U�#ǵ����(���R�� �
� y��~j?�ޛ{�WD�ٜW7��<��c� ?��o��/�i·Ӈ:N@_簞��%p<��1_7�b�	�e����.g�ױ�X��̑	b��xO]@�5>�q}���|��q�@Mޏ�^\����������t ��v��o�Zr\r��o##%A����'}	�L~�HkMq��" ���ҙ[�@_�2@���i J�&�d';) r�  / r֤��Lu -q^$q��H I�%�Z7;�jjtT,ݩM�yj��tU �$I$ VI߁M����- D^eP�Q�@�G��H� �� 	 ���DCH�(�w�"^H���2գA�a4@"��$ $!` ��&I ��D�~�21ؖ��P9�y�2���>?7<��� ش������֫[.������{��:������e�y���x�0^?H7�ܟ������N���g����m���8f��?������,<ˁ&�'�	p|�����G���@we8ָ�2���(g��}|{އ� ����������}�t�����l6W��կӍ �������s��<'ϲ$�(�Ygi$��؏ck�"��w�P#��ғ4{* ��=o������m����~ ғym:=��pu��]7
잽{�����o��O����1�?����Ln���zݽ/�l9~���7������/k�^��J��c�}�� �r+�� l��� �+���9}tXݙq�ף̍�O��90�z{=����>��}Ώ�͏�e��޿��>���/�\}^��=���W�ƁC�9��4�,-)�8�S��1@�^�n@� �h�*�0oge/��i}��=_�0 z�6��F��l�vx|g�/� e�lׯ���a9�#^ߍ��1�dw���o��~�K�����?��v����vs{���'������-_�&ϵ6w��^��Y��񚏝{�~��t�� ��K�>��������z8�@�]�������m�����19VW�^Nҍ�@r�y3 �~�YE��� d�[��
��z.�J����غ �dʀ[�vHY�Ri�9��͉d�@ʜ��YX{��D� ڶ��Nj?�9�����x��� E��L�F ��I���|VzB>k�@�U�]\���ϵw��?��Ltv� A�! ��R����U� szL&��"E#�bՙ���\�L� �by2 0��s��O-��o������:�=N�y�K�K� �y����w��s�O� kY+ Vy��h�]�)so�_�z��˷_��~���?��/� ��гi@��U����uYN��tR�)h�V�
�q}��ay�s����?��]߁m�R/s�sRsZ3��H�k�� ���e��J��rr�S��>%k�h��k?��nv�|�|�~}
� S���?矫�����9~�����4������-=,K�`<��a��u��� m�c�������}������������x>��R�@5�9�@D� �c��$@��|��ts���j�% ��u\������������W��:.����e�:�N�:<���q=����g���۞H��ЭY@���6{K�^]��! ��oT�+��� �zY� �LZ�q�; ��Rm	PZ��)H�j1@�ti K�d&�	��c�����n�� ��t��"������V�D��:k�e �i?�]ߖ9@�;���tv� ��D̕�, �i7)�pLI-R��ҭ��`�n��+ ��ο�|�S��_���� �j�, �a�>)=�8����v~{+���_�������:_^.���7�������?�+�tJg��5��+U��4�]���PF�-�:1T-��+@�L�+���9���{ ����������R�ɡ֜���Ux��z�]>�Y���h��^n������|�}�ھm�؝�w���ǔWL�Q��j�d3�`9;�3�+�K�m���h� @�1bv�`ο���s�< #�׻���}}	�C���U����{^s���Y�^�^��o���0�7�׷뗡.`>n������cֱ2	Pd��`�:���Nv^(K�[�[�� @c���(` T� �D�i� z�V���ѣ=R�IA�.z�" �����Lj�i�Hh�4x|Y�({�@ߐ�� �QB���FO�	��5@x���)hf6K�A�N;�uԊh #��ɔ�D����*] �b/m-@��o�"z/e�n@���L �'BHv D%"��%�t l���d����ο���a�4�m� *u�� �\��a������w���T����z���'������o��z\?��y}�:׺��V{{Y�A�|}|������ �������h�n?�n?����q�����!�]�]�L;���8t��ðE�H h�@  � ���������s������˶ ")�e�g����������g�����y��q.6��������u e���� �[���j�q�cg���|�|�?����������������O�)�����޾�W@/}� yY��	Ȯ#�/�-�����I��b;�@��<�	����i�<뻺�ɵQ��(%� ؙ	P�����x��x�ߟƾ�&�޺}5��^�R�������u�{�L�i�H.����؞7��맱o�3�Eo��յB�2���ny=��,]�"�nN9h���,k�%�� �	 h/B 7xA(-Zi1��K;����q�id��h?�U��(Q�w`��l�8ˣ4H���S��᷶��yo���'0��g?>�~x������ʟԪ]��ܝgZ�k����*�U*@$Y� D�h�T_0 l�
�e� ���� T�
�4�b����5����8����ڵl��.=Y
���R��t����"�_o�� \~���c��_���^_��Ͽ���~����?������L��=�<�d=�|Z8;l�}�X���pOY
HB�
  Q% � �2 $$�[4 `0
 1 ��uw�8��r��<l]`���um�Aʘb��|��w�󱳠禿|�m�h��<���A��{�����}���������?����w��!����Z�r�ә�+�gg�{�@��t��.B��I$@�i��(��`#�� @�@� � AJ�rNv�ke�%�%j`$�*�uǐ[���]K_ �1y�U�V[�vO0�ux��[9ZgMڜL����T�XV�2�"�H4	�A -3 �!��^ $�d� ������}�L^�W�(�b�����6w�ܯ�tq�ɚ c�,�,+�V��>����vu<��}���l��&���~\����vs�1>��˲��4�_�A�I �d�}�Il ����{������zƏ�� �I���&�n�n��w� -��k ���N�U�ڶu�:�괳w���?}y?6Ѝ���k�ݏ��{� ���=���u�q�6�z�ަ��"A���L� 	`X f21Ȟ�۽{Oos<���88w����W��ܭ�m���9��emFN�F���M[�>��<��v�?}�y?��6���ի�Û��^�M�ϗ��%q?}����,�=�M �H�� I��bl Je�n�	� ���<�Ȫ�٠Vj�Th���r%�J�2�?��H"	��T�j��2Y�q�Z{�"Uؠ"MaW����0 �( �uM+\@7tK� ��G��	�JV�K��Ke(;�L
�	pxܻ_�����������l>����ov������s�{��g�@HozJ؍�w�u���9��e�����^�����l�j��/��?���?"(��n0o&�:<�u	p�x������6��������q [b��B��L/�{ DH%@@) *� �����ew���{x�������4(�᫛��o�	���?��}����������Igjp����v}��/d;ۑu�����nx����|d!춶��տ������#US�V˺��������������X皞{�q_�X��"���m:D"- L@Sa1P�`� @�<vz���g@�r���nU��%�|��Þ6�lw�;�H�"������o~�%/+�[ qFk'x�������j���ӏ�Ϗ�G�X�*�V��ײN� �-�۵Y�β��Xy�V�@&�i9�� �D�H�
 � 3�� �df�A�2]z/m�����ǯc oOo�o �t��0\����)(I�@�b�6��TSy�8���@�zZ,SV����������f�֚����O>v-@����۲߀B��I	`N�=�i ���L5�6�`��L:  d02L��]�@&G=�27Po�_K���O��� ��E�xt����\:��� d��[���\�v���G`��VÀ�:�x�/���?���?�4�mop�]?_W�rtc���������7 jm�1�	p`��@�h� h�� 1�l�)� 0e���^����(sP�>w����}��n�x��@������9�}��Gd!zJZ���ۜu�\k����˰~��� e�:y��?��������+��m��os��~���+`�>���'��1�� <�}� HD&��% :
��U���C;H�$I ƲJ�h��W� Z&Z�@�b���LÐH�� �B��H�J-
�b�0 �͖�- ����LvM �� ��ȞL� �H����`���_j����� S=���R�g!��"����|#�
 1��0)�4zg��H��Z�m 2�5 F�8�k �Y5�)�x������ �~ĳ@����P�jG �q7]�4�lYi� h4u�*ֵ��F{���eJ@V��4���?���X�����<��db�f��:P��|!� @� �1P�,'se6�Rrfu �O��9~��q(��6T;� k�YY@�x�B�V�
��4]e�� ؼ[� �u��d[�������_�˾��>>o�Z@��(�'�V��D� ( �b�V��b�����jK���mB����w�L^wg�HkOTC��B	 ��T4��ɓ)�FK�lUQ�u�ȮHH�$��_���|�'�^kzݦ�='�d�� ���ZI�$ B 
������`]���u���g��"��:�,�P� b��3@T�h�Q M�F& 2iY@˰a�,ە��ʕj&��S@�R��4Z ���.� %*JV�FkK�fZ%{���n?!eM)#_H �@00��Y�ܽ}�����}��/����y{ dh]��7Pk���)	����j?��*���fF�qoi&��>��6�[�tզ�V�I����]�P|�����m̀^���?翷�P��XI�cz�yВ9�d� '��>g��p����� $��l@�t�ª�׫�_��׹^_������D��zj�����)8ű�rk���� k2�,�[�����_���m����*�i
2�:Wq�Ӎ _�D��}/�Q�m\@���������0��5
p���1��̱`��9ߧ�@:|d��� d��2H�`V��W���|��Ώ	H�)iP�J�� &S4@nŏ��%F��% -ɔ ͆� 5E� B@������%0S�U k�@���Y+�WO���(��&� ��h&���S�"�H)K���l `J�w � �f0 dry�ϟ_���mE l��Z��E ��]���^1�Y����(����]���&`�]7����� k&k@�����ǿw|	`�����) ZC�2��9 ��$`�~������G6���P ������}][m
A�jַ��=|W K�,�&�-�Z����{[�z�{Y��)3� @�\�>��?
�X���t�R	 h 0� IG   H� �����߯ �)�� l�ܾ<�� �ݦMӭM��������֪ Y�Hl@�Z�k�lܹ���벫 ���7���>�/#@�,@ X
��@� � ���J�* �J�����l$W�� �. J�K@ua� ���
l
(�|#�T0�Y0��d ��W� 0@�m�*��?�4����@A�$٥��rU@�y�.� P�� *���U�eU!�U�!S-�&(+#�� f��dD�� �U Q6b@���~����_�v�O-:�x�dv@o[��P/|�M���s_~�x�}����j�k������������k �=
�����e˶����ϳ������K����O�
@�,����&# .3L 2�� U� U��
��������/`�O�~� S���sk������M5�*�|yߗ�g�m�}�?�x���_��W@�}�����A����f/�����k ���w�������~�w@� @�֖�̀*3�� ���$�`4��� PH@X��
p��?}���6�[�V-�ֻњ���u����������}���� r��O[ ��(V�e�H�aQ�\�s�<����O?� 
���� 0��2
�%��.!F���U\���z.��<��Ώ�.�˕�i]�Ad<��^��������~Z��|ݺ� ����j�wMW]cן�!�������d
`�L" b�P1@ed��@� � @,�U+�X ��� (���s���7��������E٩�,`ԦM������m�y����{�w� ���� ����c�c@�a�U[��QW������9Bd�g���� �t ��0� !%�i 22 �l!� Ī6,W 6	�����ϭ��s���Rv����-���!�=���5�?6~w��x�?��Py|>��0ۙ����u�]m���w���!�����l|`: �D[2�2�P �d% P��Y�R�*�M#@M=ժ����W]ز�* ҈lm5���x�U����2u��,�)*����C�������
�Y��L�(� �������ܦf���?�2	[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dhho7g8gccfgy"
path="res://.godot/imported/index.apple-touch-icon.png-501548209163ccca221df4fc6a7c3c2a.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://html/index.apple-touch-icon.png"
dest_files=["res://.godot/imported/index.apple-touch-icon.png-501548209163ccca221df4fc6a7c3c2a.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
compress/streamed=false
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
+��Y�8f ��.�GST2   @   @      ����               @ @        �  WEBPRIFF�  WEBPVP8L�  /?� g�8�$5*133�o��rA/>0�m#I���zf�@>�p�cdI��?�5���/Wd��<�?���   ����	�~ 	�8s��H�(̳ث,�`W�Ѻ�Z�<ɣ�0�*k㦋��A� �qۤ�7
Ū6��sIY������Ny@D�I��ꂬ�� B*�s�//Q��߿�B ���g@���,�V�OۦdM���TJו��`�1"�<?7��#s}�`�ͦ�RN'�W�9��y�P��*�fS��g�b���C�CE�����TD�R�Ni���,M)�� c}���%�&]���m��ֶ��m��|?�S
Q}F���/1� ��+5�o/b}D����`)]�|y|��\��t����s} ƥ�l?Oc�m�i�n����*6џ?���Ѻ,��唂h����>a)��K�s��n���Ӝ�~;���2e5�b|��b�g5gKv�����Le������!���k�%�8m��H+��s���R}6D�������u<���/���3���@�1���m�>��6����Z}�V�p�].���^}�K� R��g��\������q����ˢc�)!v�z]TY�&�\���e��@%bh�� ��݊Xa,�+M:��n7F��פ2����1���R�)�7�P�� >>� <=�ԇQQs���ޭ�3^.�}���>gfK���� !0���n���y�0;��~����:�C��D9���U��&�{۫�<mz��1�������g?��`�,�^�{����l"�K��"PE����U��	]/�9;��� ��||D�/�4�]�TW�M�"���?C�c}��Q����S�n�w�ҏ����@�A%zz��V_��K)�D"Dy$ b��B� ]��uoo�yWgIb�f2��Z�,[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://27tgjb452f2w"
path="res://.godot/imported/index.icon.png-86cfb60f248dbbcbb938966694a6fe5d.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://html/index.icon.png"
dest_files=["res://.godot/imported/index.icon.png-86cfb60f248dbbcbb938966694a6fe5d.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
compress/streamed=false
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
MGST2      X     ����                X       �,  WEBPRIFF�,  WEBPVP8L�,  /Õ�(n#����3�1�V�){#F��S@\~r#�r*��|L@@
,i��̬��Hۦ����mۆM1e�d(۶������mѶm|����i�7Xr]�m�-.ڻ���HN�����k۶�6�c�sѣ�= E��yDP�$ٴm�1�m۶m۶m۶m�]}��m��Z��m�H�����7�>�[�$K�$۪�����e��A����I��tn��?�F�$mꦾ�W�6g۶mo���l�l�,�mg�t��&�J�$In�l�xX�`��o۶)O���W��������Z��.��0C�.����iw�pm$d[8��
$�8.��mۛ4����� S	��*3� n��۶�D���W��L�c�-L����mڶ�}�ڶm�~߶m�?���m۶����$I�3���s�������?�?��������O��?��������O��?��������O��?�������L�2�j:�����N�+�4v�_������jӜ�|[��Ri�;�4��N�#��0�+V)O�����$������l����Gj�b�Ze�Gj<��Qk�]�l��G�c �A|�S�|��@g�	9��]���b����~�x��#`5��A
�o?{n?M��2 &p	���7�d�HX�l�n=N\��מ�(����U�   c�f�� (hn����=]��z��:�7�fA�v�Bx� '+���|���(nDQbenQp �| ��E��+5N_<�L6�|� 'p��B�C����/�>��$&���L  �qw�AX�q �~4�+q�55*���ơ؁0T�AK��l�ܢ�ֹI�I%�[  �y(�%p^L�-x�K�I[�fnQ�Xm�h��� 2yp�q���E�7��w�  �	x �}l�,�����L�v" �?�l������ᖀ�P�(��p+�����D�$`�^�-���C%AJ��֡  �Ɓ� [Ƕ�R-��S�6�5X.Ri)����6�6��
)r�o6�JK��5�/�un�����-  ���� ��8� ;������s%`�^�Dw�,����OW�7c�Zhݽ3�5�U\���:���#��<�����t}$�g�_��۽(JBsm�`�"۵�Bp{}�{>�k��n���wzzgg[w5���҇�t)��������]O�l`�S[y	64��^�gͺK%G��lI��z&���G���I�">�f��x�:pԞ��	�a}E�_���7��@=�����M��z��H[DHbz�b��GG�l����/H]�R�"$�� �K_G��� ���"$P���тB�
� 8O@��O�@S�r��`�>�O�! W�+(t����`G`
�ƂNp�jf���X:Z����` �N� ���X���ς�8�-����$���������wz��- H����~�8��;C;R�W  �X���5a����׏���(J� g[w�_?�	��h	��2�gHq�r���x��S[}�V��X�0�A@@o8k=:=_(NQ��E���x�b=g��אF�f�g�/��	���͂�@,o���>�O]�����pF���Y�fZڥ(J�&-���6c�xxF�	�-n>N�U_d���H`�34��-�[�6�⿩Q�[@\�F*�_Q��Q�J�{�1�'�S�V/����}�����zYPͼ���D�[�j��Y�t9�CÍ(N�(ɫDq28��8�6]^���r��n7�  p�:C+A�������&PIR�e���>��^�DQ�7�����#����K���3
  �������t�3��OO^� X�w�z�a����]��}�f���X�$��N���r,5��`�'O�5��(J�25���끋�#�b"j<\� 	w�F��pQ,nre�Z%��Rmq�pj�� ��+��S��Ή����!C�^��v/��O����K�C���m�h5�I�����rL�-��� � 6��>�反C  VB�F�9@t�΢(9��;����\2�EQr,�<��>�w�~������}j �;���`/��c"����������q��ӄ��>��@�ٽ8�u�����2`�����/WA�mY�el���@�� f�g���3  ��!�����^����Q �-�Y� ���*Mj��4�-o�  ���rc$��{��C�s  HB��|$�N��M-�)�C��.����X*d���d;!�-��n ޼�Ǎ�U�4^�� �&4rJ%A�@2�-��l	��P���Ou��M�:����ƔR(�� ���F�o  ��:�� ��\$⤥]��-�|�[�e2y�}jY��=Z����U_�F]���f��jh�;�}l���.��or�Ԓ����\����Z�(N�{g+��ɓ�Љ�×�W�
���]�ʿ�D���ל���	{�y���g�F'kQ����W'k�E ��������.�LN�[��}��޲P��v�J��-���CGs�
^�Ja%��c���X"j��ܢ ����Ԭ�������6�'����.`VW�k�gl��e��/���!���M ;K�\E�C�]�/ K)�C�^��|&D�!؆��K6+�=ޡ&�	���B�
�>�����"��=e����߄���!� ��r$@IR;�z8}�P��<\�  ��������f�����ǦfK���B�^�b��� ���25��;?-rA34��^5֟  [�V��{�M�2 &S�=����| x/D��	�G�-��l	X�V|>�z�0��mF�%�`l�K!��d�� �g��g���~T�?<�� ���ϗC�V��FE��w�,��"oZB ��.���.'���X�g H	�=K{�J�]�w`)��B$�P�K���7�s�o<C�y ��C�W*�\��G��ow,
��yc @IR;�I ���%�����X�$��V xwl��$X|��-A�"K�ՙ�
��)��. ,|���w�߅��X`ii��Xi���G�?�w6 \�97� 8#���<(�����.�V#֪��C����  �ݫ��ѽ���!��|�6a<\�DQ��.�=&'C��� �uh+Ij�|{]�m �/�9- ���'z,'�_?�=�<D��5 �w�EI8O�o� X�WB��!څ1��#'�˛������(�WC� ,nr�q�Ǎ�M /����`@PpН��gl�LvP'p��"DQ��! �����d��}j��H��9{���1�:]��D�%���EXYD'����?��%� ��<j��DQ�o�:7���+A*��C�c��B��E +w��������x��-�R@o��7���7-�m�m�;�/�w����ѽX��beq�i�������?���?!=�T�n?Mdk�;';"�WX���������~8oq�a���CXcQ���5�X'a]�:��8�uh��������AQ܈�D}����ֹ�t}42�Hvz�Nδq�VS����0��M�Jp[�89�z�:IvF�����:W�/���ב���50ع�������Ny�+��U�����l��ˑ��E*-5ԞJ�Z�)Mj��TZ��]<X�i)'{y��ɼx�{�����l\�w�޽:}�P]yKD�<V����/����;���Vn=N<X����Y�wX�ʴT@2E��ϼz��`92s?'3���u�rX�o�\]�w02٘��{�y��km������!ۧ���._4�wۧ�D��'�|�d=�ם��������ǩǫ�����6
�Vw�@�����}�E �_/�~5֟��2~l���~<^�|����o��<O���3�*JM�J��ͅ�G�í���ܢ��o�+���b��i	����!/���"�rj}߱�{���81�����u��Ri���R�4�~��zjp�0�*�M�ʫ�_@R7��}e��,J�Z���A�x���ԬT�?m驡�V�l��(U�� '�@N9�������E!����m���3��J��ޅ���=Yd�;gt���lV������/���Z��銑JKAG[FW�"���?��!I�%c,[ru�&�%�O��l)��p���^��0e�����x�
�ѽ0�;A�fK�O0G\�	r�`\�y��g]��/x�6�b�ȸt}��㔀��	��'/CA:�\��N��C�Y�	_^�ܷIv��?A����OPO��;���K�ܢ�ѽH��d�RU�(�奯���Iy�ˣ(nTU>��J*-ut/���]
�q�PG?A\ �T�r�}�s�V��7�=O^��>f���&+�����QG�Jfis�d��ͅ����ќޙ�x���MVf���>�����Y�f������  �B�~��e�B�$DM����N���O�̿|} `���WĽe!D"j�;�䤭s��s���c["NB�_�	xQCA3�����2mz����(��0��\��QO�,h9?4�)瀵 ��lɞg�; ���ٽ��?�MWf���.
O�o?{Vw��S�����$L'��9��S��˼��y���(��ύMW;���݋�����W�=�K;�$�}l)���럎Ǎ곷�F%��:�Wr�of��&�p5��WB�K6*�V#+��5���F���ͳ�2DY�f���p 0=_��$�~��A����� Y������./@��s@�6;�K�Za)MjK�  vB�]�	�B �`9���B���c  HB���Hf��
�����S*
�a���
��d�yP���LQ�(�8�v� �N))�����Py���j�#�|.��P����,|�N�?���9 �"��)=P�l<[)���(i�2E �zni*�����Ϟ�V)���ҿ>  `T�p���	Xy�:�������ܢ@0�GȎ+e���l����d���G7g� 8}!�J_����΋����Y"N�l������r�~ �Bqli쀀���Y�t7��/����44�Z�v;��Cė��`���~�I�j+/����20�y��8�m0�s���`4,nV6������ّ�U�&��˛�l��G�}i�R�h
��u�&S�_�&����E]��H^��{g���o�"�n�_��s���a,�$�����rd<[��?8ۺ�(}������ݥ��x��p9��oq�$,��P�+> ��`~A��u^t���/�{�W'���lT��ފ�F���V}��lTRi���d`�35_:U�]�=~`:�x���k ��J��;�s���ƾc�+����Gϓ�Г��㗡�EanQx�2t�~,~�6�{y��0`<���k  |��a^@^`��| ��u�^ `�h��|�|�)�� 4C4��g����@��S��+`7���!�6��ݰ����)h�4 ��3=A�^
r�ԇ��z@�#a$���Cs�� 7�.'�u�W4A���~�����r��������������>?S����9h�l Lu|.��N�~�r�Es���@�M9!�-"U�F��^�T햸a~��U�Q""����+�n�r��"uH���z�~�����t2�$��F62Qm&A�adG#�b�7T��zG�h����k��ll��z�J�E�ǉ��0����D��8�l�o5���n����#s�čXl;�W�=}�v�,�:�>64D�� �:?b�cc���L���t�	*�m�b�Xԓ���h�E�@J�@Q,4`�-�%t�>�p�n���7�H1�(�|G�'���2?�����:V����T�HS(����qR���1�/H5�r�fo��՛�SxY�ˢ����ʉr�a���<��H[L: �
�'��A�d7T9-�%<��b7���k�sذ�ڠ6?�E>�)�=�w!x�ǩ�C1�
�(*��A� ���|M�kY߂'�� �Į��#���؛����Ӟy�O
�'�''B�@���#:�db[�"���&����>�*����i�@[C�6��[�0m���B�-��C:B���1Z/�S���W��p�W*۸F�	i��7��xdN�
�3� �zZ���`C�n`���ƍxv(�#."=x�Hfﮁ |1�]8i�8G�m5?�7�?�z��^�6�x$LG\�
i���ۏ�ef�����]��K���؍4&�I�lD��`g��mR�L�4�B:�huͷ�ݑN��و�'�tb�O]��l�$AlGZa�~�nG`�$��EZ��'z4�̱�����	z!���IKA�@��DSj�Ė��ˑ`$��}�!�&."ݱ����R/t�x�:������O� N ]8)K�!���;���E�c���,�A���`H�m��x�צ����� ����~�J�]���\΄��'����l�i�sL��f���=�TQ����cc/�E�"����x�B&N@j��<���>��~u�g@*kc��^�_�dh(�C��5|r,�0N�	��m�ؤb��H	%&�KI�c9�ނ�J'u�e��{��&@Q��b�A*ʘ�g�6�kϙˢҧ�M��c%2{���y�� X=��qs�$lVۭ��[.j�SU℉.*��c0����%\�J6�� x�Kb���<���.�|��&�Z�mK]�c?1m��˓��J��+2c��r7{��q�]�MxT��P [�f=3�t�]�yW�:%��ԟH�]�W+��\��%6���:
��m�2m������.�V�(��mļ�Z�6��W8r�����J������T�sz1�r���%�aj�41ū^��l���ѣ�l�Ē��ϗx,��`06�NU��)v�''VNl`._L���B������+;� ;�bg����pB:�s+��M���X�{c�ɢ+�j�}�bj�b������� 5ud��]�����ܛW�՗u%��xS`�����z�Җo�j[���V�+��l|<�ʻ��ύ�5X�:V��=��O�zPQ�G�Ʋ\��^$�8웩��XY�;-�uA����}0*9>�_`��t�������]�'u�cI�&�8h�%���[�>���T.e߃4�)�=���
bm�UN%���䝷��V`�����Ӫ����:�-�I�Rc
bU���W۾����5����Z�J{z��g負��b!��+j�~��b��y�)1���V9��eŞ�؞��]w-%O�S`����m��I,�\�����_��J�hQ=q�Y�(���9P�u�*'�����	bzbz�3+�/�@��_+ӗ�+С�??(-0��
bQ�����[8U$��@��˵��&��!o�LN/���o1�rc�8-�B�/0�"6u~p���ߘ��]��t�z�m+�}&R���I,)���zj*������_�hV����ښs
���󑠤���/���KZ�����e _�[m��w4��k�P�}?��H�q�]"�p]���U G�<q0R����rg����dq�L�V`���P��V�g�dA���=�<<LBJoI�y�dw���8
��`�҅�����X����OBl��bI�\<@�D_@�Ao�L=�o )�*�FO��\�O��|#(x]�e�7�}�H��� ����� !���Qb�>��+���`�vHw >I��#�ˆ�r9��N:�rK�9��>o۝���T���P����g���_ӅW��]�:y'%�T�Zr�]A)6�@*=<��'���0�
o�t�
*�Re�
���Ը��X���nbR	�1�bK�*x��K7F[jk73={�.*�� "�P�xSy�TP�����ߟ%U�G*����R	1	��~F�B����5:�^��������c,R%N3^5�ڋ�������9�SeC�#%NX�bR
���!Z�jrd���nr����z��3ʑm��)�����"e�ci��(�Z0�.sLA�C�fg�j�#�A���K�ᴬBI�X��wh�8� �h��v�:7I;�=Ob�v蟟>C4k��t&N�F�."?�BK�[��)"����
-�y�,�ȏ�`�,��Q�-�1*8���C+��e�:�[�/�<�¡^1W�ѓ���I�M�Л.� �谥�:Q�A�����B�R��j�t�~�M,��4j��Y�iKp��C04�:��w����6�Ir'�A/�����.T��ݧ"�0�=����NY��F�!V/��u�T�����M�-�9"����&LoD(hB�tD?��Z��Tu�qs�]J2���׺ZLc�w|�S�����o�<
�c$���nҭ%�mlk�.�����#.�)�o��܆�w8�Rg��c������� �������vb�O������|�#ۂH�-���_��qX.���Ώ����v)�t_}�l{���:~p�AX�W�$իs,B[�-;λ�g,iǫ/xk�\�vD>̏�9[�*b����ؼ};%��B�N��<?
�¥�kF�_߃<��Q�2v�z�	47���,U�K��!�(�-�(�r�,����Ʒ���1\�r���g'̗U�j�9QJ�rn�A?X�ú�� *��ٱ��\��_�*�#?�G���������y���i��S\��np1rb��MB�_)��VYK�����D����"7)�����MN��^��,�w΀J7cM�A�@$���p����s�s��ֻ�b��vK�l^��x�=?y��U ��і5%�P/v�C�ti���e��&7zR�b�uS�?�G�g���&(K-���S�t�X�����"�]1Υ_���nR���œ����^pQ2�7첽b��3�ba�\��uu2�~w�G�����5��0��{�����\�w��I�c�P����߬��x6μ����!�b���_��!��a2v�ſi���4��C����������rI����f0�7O����S�Ţ���Ϳ��>�����E=o7S�S�-���o��Y�YZ�)�F"-��b�O�k���x��!��P�]\|󋧦���H߽�1��l��lΚ��iu��`ps��C��f�X�5/Q�\_*m�f�)稹����a>$O;��C�a�;V.���cq��i^��R5�X��t%�s���=xȸ�; 5��3\�.R��/���.�۸7���w�y�����Q4��/F����L�9���6ލ��>#߆�����i\�ߪ�l�k��u��G�x?�����������؋Kyu7Ɨ�����o&�~,e��xy����������u�ݛ�9�I�[soك�h>.���۸}��yg���]���Qq�����i\��)��Tƹ�ŭ���E$Z�W�B{IKrD�\'�"�q%�$�&�_e{=s����D"��_�W�1/_[��e��IE�?�=D��®i�صa�@b�K�&��ۺ�+� ����^��������ǥف6M[�
�	�E�ƞAK-�T��|L,��yA.;�vjIƜf��GL��;V�<�zY�mr�r�E9U���/�̜f��!UĐGVpV_~��ƣL�+��u�Ui�F\^�i��^�]g�Kx��X��\����&�!�y�"�+!�A�u!`�;@��P�+Z�|`n�����IGV�m"��KZ��$�aͷ�d�����v̪�(�p2���^����N�	U�(�����I9�7��#��0;C/���m�J�h6ӕ�=�0Z0-������~܇1?��$�Rnj���5����$1ׁݶ�L�w[Ju�K�0c{��>�{�Μ!��,�)����O&��ă����/�:�II� E��e���3A���s���Ed_�! Qn���){Q�4f��͎ns���d�v��W����R��6gtm q�Z,v��;Qr6)A���E;��5�b��Ē�M�'���3�M3���PU�ʵ�]7'��دӜ� 6�cN�Vw�*<���$r[�cJ�����$�2>�*�Rb�)�*I|�����"q��@O����o��V�F�AQԧ�w�(r~�t\a6(�;��EC��MH3��EqcܨF$��͞k&bi/�t��-ƈ�����2Hf�8�Tr�e l ?)�ɉ]���%S�>@�]X�[��L��������S>A�|kF.�U<�u�Q-z�bw�������� 3����$Q�ܡ�I���׍���{��E�i�cy��h�����a�1(Ltn1:M-s�Hm��4����7�^�?r���ңIQz�/��dç(j=�o��xAљ��Y�}�V���AeD����eZ�ij�S�SۘM�w'������2��f��B���'NZg�xT���h}���6F�`�5Ց��y | �����c�,Z+;1XOޣ��T�>��ɀ��3#?��2����a�D�}/!"|�H��XN�t�;y(�7�L&���O2m/x�]�5�!0:Y#<8A������ZT�����)�����T}�cL��4#?������Y������_��ٙp��۝Y��wj*:11��Ё|��a/�?����&S�4biՙI+k={������>}s�:��E61��IuqdZƑwE�̵]<��	k��Z�=��da2<"����}�=v��s�U�)�c���e&�	`
����c5�ԑ䅎�9X�E��Um���%3ő}��X��Q��T�%Յ��(�y���Jb�Z�����d��'[:0$�ĉ���۔��aO^��\Xy��J�WoÚ��ё�!8sx��.Z��,U�����	�N"I0�i��("���w�O!"�NޥHc�[	���)����ߵ\��ȎX�I�G_|d�ٵ�mBҸFA�>�����ҷE��ה��"@$��Yu!�}�2�o�V�El�&��r�TI�����Y0A�l:ɐ�ŵ�!Y���H�+Յ	/�Y���Cě�i0l�P�r��i�R1��Q�J:!����Z����v�lݬ��Bace��,�,���3��KpZ�kƱpK�Zt�������&Ɩ��]} \��(&��Ƀd����G׳�R���md��3~�>ZFpؾ ��Y�js�����e{椹[�=�o�2��p�vVw�V��s�Lq���g�+�}�a�ߤ��U�5'_�Y�{uN>��������E�x��K�AJ�I5�4|�WAh�Fyl�If8)��(�n<�B��W�%�6��7���x��e��G�ې拿\\�'��_	.n���_������G�����G��?��������O��?��������O��?��������O��?����� vE��/�;:[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bgw6fu4pdo585"
path="res://.godot/imported/index.png-598db4bc1a486d88543275db98553c06.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://html/index.png"
dest_files=["res://.godot/imported/index.png-598db4bc1a486d88543275db98553c06.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
compress/streamed=false
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
�e3�9��Z��U�DBGST2   @   @      ����               @ @        �  WEBPRIFF�  WEBPVP8L�  /?� g�8�$5*133�o��rA/>0�m#I���zf�@>�p�cdI��?�5���/Wd��<�?���   ����	�~ 	�8s��H�(̳ث,�`W�Ѻ�Z�<ɣ�0�*k㦋��A� �qۤ�7
Ū6��sIY������Ny@D�I��ꂬ�� B*�s�//Q��߿�B ���g@���,�V�OۦdM���TJו��`�1"�<?7��#s}�`�ͦ�RN'�W�9��y�P��*�fS��g�b���C�CE�����TD�R�Ni���,M)�� c}���%�&]���m��ֶ��m��|?�S
Q}F���/1� ��+5�o/b}D����`)]�|y|��\��t����s} ƥ�l?Oc�m�i�n����*6џ?���Ѻ,��唂h����>a)��K�s��n���Ӝ�~;���2e5�b|��b�g5gKv�����Le������!���k�%�8m��H+��s���R}6D�������u<���/���3���@�1���m�>��6����Z}�V�p�].���^}�K� R��g��\������q����ˢc�)!v�z]TY�&�\���e��@%bh�� ��݊Xa,�+M:��n7F��פ2����1���R�)�7�P�� >>� <=�ԇQQs���ޭ�3^.�}���>gfK���� !0���n���y�0;��~����:�C��D9���U��&�{۫�<mz��1�������g?��`�,�^�{����l"�K��"PE����U��	]/�9;��� ��||D�/�4�]�TW�M�"���?C�c}��Q����S�n�w�ҏ����@�A%zz��V_��K)�D"Dy$ b��B� ]��uoo�yb[$$�����F[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cbby50724oj4c"
path="res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=["res://.godot/imported/icon.png-487276ed1e3a0c39cad0279d744ee560.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
�I�0_늽�,��extends Control

func _ready():
	# Called every time the node is added to the scene.
	gamestate.connection_failed.connect(_on_connection_failed)
	gamestate.connection_succeeded.connect(_on_connection_success)
	gamestate.player_list_changed.connect(refresh_lobby)
	gamestate.game_ended.connect(_on_game_ended)
	gamestate.game_error.connect(_on_game_error)
	# Set the player name according to the system username. Fallback to the path.
	if OS.has_environment("USERNAME"):
		$Connect/Name.text = OS.get_environment("USERNAME")
	else:
		var desktop_path = OS.get_system_dir(0).replace("\\", "/").split("/")
		$Connect/Name.text = desktop_path[desktop_path.size() - 2]


func _on_host_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	$Connect.hide()
	$Players.show()
	$Connect/ErrorLabel.text = ""

	var player_name = $Connect/Name.text
	gamestate.host_game(player_name)
	refresh_lobby()


func _on_join_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	var ip = $Connect/IPAddress.text
	if not ip.is_valid_ip_address():
		$Connect/ErrorLabel.text = "Invalid IP address!"
		return

	$Connect/ErrorLabel.text = ""
	$Connect/Host.disabled = true
	$Connect/Join.disabled = true

	var player_name = $Connect/Name.text
	gamestate.join_game(ip, player_name)


func _on_connection_success():
	$Connect.hide()
	$Players.show()


func _on_connection_failed():
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false
	$Connect/ErrorLabel.set_text("Connection failed.")


func _on_game_ended():
	show()
	$Connect.show()
	$Players.hide()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func _on_game_error(errtxt):
	$ErrorDialog.dialog_text = errtxt
	$ErrorDialog.popup_centered()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func refresh_lobby():
	var players = gamestate.get_player_list()
	players.sort()
	$Players/List.clear()
	$Players/List.add_item(gamestate.get_player_name() + " (You)")
	for p in players:
		$Players/List.add_item(p)

	$Players/Start.disabled = not multiplayer.is_server()


func _on_start_pressed():
	gamestate.begin_game()


func _on_find_public_ip_pressed():
	OS.shell_open("https://icanhazip.com/")
kR�[gd_scene load_steps=2 format=3 uid="uid://jhdlqsokif5o"]

[ext_resource type="Script" path="res://lobby.gd" id="1"]

[node name="Lobby" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0
size_flags_horizontal = 2
size_flags_vertical = 2
script = ExtResource( "1" )

[node name="Players" type="Panel" parent="."]
visible = false
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -126.0
offset_top = -177.5
offset_right = 126.0
offset_bottom = 177.5
size_flags_horizontal = 2
size_flags_vertical = 2

[node name="Label" type="Label" parent="Players"]
offset_left = 26.0
offset_top = 18.0
offset_right = 142.0
offset_bottom = 32.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "Awaiting Players..."

[node name="Start" type="Button" parent="Players"]
offset_left = 68.0
offset_top = 307.0
offset_right = 193.0
offset_bottom = 336.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "START!"

[node name="List" type="ItemList" parent="Players"]
offset_left = 25.0
offset_top = 37.0
offset_right = 229.0
offset_bottom = 296.0
size_flags_horizontal = 2
size_flags_vertical = 2

[node name="PortForward" type="Label" parent="Players"]
offset_left = -124.0
offset_top = 375.0
offset_right = 128.0
offset_bottom = 429.0
theme_override_constants/line_spacing = 6
text = "If you want non-LAN clients to connect,
make sure the port 10567 in UDP
is forwarded on your router."

[node name="FindPublicIP" type="LinkButton" parent="Players"]
offset_left = 168.0
offset_top = 393.5
offset_right = 341.0
offset_bottom = 407.5
text = "Find your public IP address"

[node name="Connect" type="Panel" parent="."]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
offset_left = -138.5
offset_top = -83.5
offset_right = 138.5
offset_bottom = 83.5
size_flags_horizontal = 2
size_flags_vertical = 2

[node name="NameLabel" type="Label" parent="Connect"]
offset_left = 14.0
offset_top = 11.0
offset_right = 56.0
offset_bottom = 25.0
size_flags_horizontal = 2
size_flags_vertical = 0
text = "Name:"

[node name="Name" type="LineEdit" parent="Connect"]
offset_left = 17.0
offset_top = 30.0
offset_right = 173.0
offset_bottom = 54.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "The Warrior"

[node name="IPLabel" type="Label" parent="Connect"]
offset_left = 15.0
offset_top = 66.0
offset_right = 57.0
offset_bottom = 80.0
size_flags_horizontal = 2
size_flags_vertical = 0
theme_override_font_sizes/font_size = 16
text = "IP:"

[node name="IPAddress" type="LineEdit" parent="Connect"]
offset_left = 17.0
offset_top = 85.0
offset_right = 173.0
offset_bottom = 109.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "127.0.0.1"

[node name="Host" type="Button" parent="Connect"]
offset_left = 181.0
offset_top = 31.0
offset_right = 246.0
offset_bottom = 51.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "Host"

[node name="Join" type="Button" parent="Connect"]
offset_left = 181.0
offset_top = 87.0
offset_right = 246.0
offset_bottom = 107.0
size_flags_horizontal = 2
size_flags_vertical = 2
text = "Join"

[node name="ErrorLabel" type="Label" parent="Connect"]
offset_left = 15.0
offset_top = 125.0
offset_right = 257.0
offset_bottom = 139.0
size_flags_horizontal = 2
size_flags_vertical = 0
theme_override_colors/font_color = Color(0.820312, 0.291595, 0.291595, 1)

[node name="ErrorDialog" type="AcceptDialog" parent="."]

[connection signal="pressed" from="Players/Start" to="." method="_on_start_pressed"]
[connection signal="pressed" from="Players/FindPublicIP" to="." method="_on_find_public_ip_pressed"]
[connection signal="pressed" from="Connect/Host" to="." method="_on_host_pressed"]
[connection signal="pressed" from="Connect/Join" to="." method="_on_join_pressed"]
Ԓ�S}m���5RSCC      � �  >  �    �  �  �  |    &      	  �  �
  �  �  �  (�/�` �F ڈ�N0֤1wA�|�̔�(>3o��� �= E��~ �=P��F"S[�M:#����KW Lq��e�֞��r�C c5�2��v������ȉ ����Ξ� �'��uR�؇���:����DB<��)���|c��a�Q�6�g�LL�ɞ�v=^Λ���! ��$E���y|�yjr�B��y�6��jJQ������NLTj�������&(��7H�����n����l2�/��s���dLh������Ĝ-7��og����4�q���#�c(� n�� ��d3��&x~c�+I�f����d������M�6��:?P������B)qG��%hE�>��K�CyV}��%4����6)�	4NC)x��q68�B�&����n�)VQ�LU�R�����D2�Ñ��$w6�
wY���Y����#)�04�P��s����5H��?�#x3m�i�)��[YE�`�����{������S���#%Ӧ=��zѷ�����^��n�^�5�r%C3fV��V���WugxUA1�'���Wc��&Y�]S]�ੂ��Vh��-�V���N)�#Y�f����_,k�̚�����ɐv�SŤTũiI)J)Jub�����Q�(K(ƤN����fMb��Z���$u�Y}r�#�%U�$%�f���HBP���R:���s$�Q���~T�'U1-D5kʴ"�O�R��**5�mf��F�բQ=u���ڑ ��B�: 8;��ƫ���hZ�(�h�1�˯�{[��ԉ*���.;�w[� �e=�Ldn�G�B�tyʯ��we �S���F�����u�d<:��d&
&��<jk�;�_U�������	�R���a���_]d�_4��0uب��ł,���8��f���({�����u����I6hX�`���s��d��`��3���^�����@gl��Z*�\��6��`���}�l�:Y%��"���ٟ��ݮ����ns��P2�C�,��b��#b �a6a�֦���(C��G����}��u�j��Jl�®�*l
��&l	K�N�Ol��αG�k�J��ʱ\f��&���f吳<F��{/]�iٹ����YG��2�k5�J<˟�_�'Y��t}i	~�}^q�W]Ǎ������R�?]k���uC-��;���ղe#����i���t�K+��Q�;��%7ptl��Ė�Jzv�c��V�����N5܌R�4�<�XN�{�en�+�'��z���wy9���8y�����vl��o�s?�i�zjs��ǿű\�>�
fNsmA8��|���ث=؊�����E��"	z��>C�7lkæY���H�GE�j��tlB_��Y-Vkwh��2��:�a���b苡a���CЧB�8�0>�-/[Ql���-���[PڬiSF9�0����b����:n�ĩ�O]?F��2��2������.pR��:�U8C\�P*�ڄ�.,��2�wu�9e a������������Q�GbG`G�� Q�T�:�H*��"U��1T�P��ǆRA��M� ԅ��)���e����� ;;@�� ��B�B�P��2�0�o����^zʲػ���.�Eb}Pv�r�[�K�6�u6�]�_��f��3�d?؃��9�ebӬ�f�[��Y'�=�0aAX�mcG�9Kg�X��]c�X:����A��;�Ek��$����[�C{P,�Q{e�,mgk���ᨡ(Č%2"##""I�tp���"�@cb�C��!%)��$�����-��x	tm���m�Ȗ+�<�&G
���o�}6����r� ;�4xn�ȠY�e/�_}���N����6��Ƅ�
U�U����*a�	�.��	�V]H�!v���"��j
�����3��.��#^��Q>��Bg�_���s�gb����[�O����av;]����v�J������\t�A�����葩�l��c���Sh?E��9]|��eDA�Y��C^��H�p&IS���х0��S|�߻��9��XEh�pW7�47�U`Rk��"��3�Ք2�:7��p��� x������3	j|Hb;|D��ԭe��gm��^
���G{�'��<9=��M��*��� �'bL�Ă(��P]&D�3 rN膋�6�`�� 4��X���I(�XA�F��:$����kc`���)h<Q�V�|<^/ sI堀�/%�K0��{�cl�(�/�` �A �jp70,7"�TsX�p�kZ�#�n:�f��]�][}3�-����?�~�qc�~޽���d�Qy{p��υ_�x��0�8����6������p;��t�"_�R��e}�_��^���~�KzE����٧�@���F��q�h`0r�F��⻟�n?ȇ<!�?��q���~9��i����_�f��u���m��V��_q��_<�(㥸�8�g�-����%^�x�'����/:��]÷��z�o����³>�Sx5��A�?���{������'�>�������� ���0G�����?���T��gy���[�8�Q��<�s����'o��\�Kr��M���}���?����#^ԃ=��z��>�x������R��S�Fn�y7P��r@-�P(��:[���Mg���)��s�9לa�+���i�r��@Ng�Y�tq�8E��	�����8��)ʼd"2�z�6�Ӌi�\b1c�5}�h&s���Da~0+�L.s4e��JN�2P٧�S�)ŔZJ(e�ҭ���Q��ceX��Qn(�\�Yz�dE~"-��HC��i�Cf!��M�#�L����A� �H�ɀ�"Sr��j$5f���@c���hf3V�����6�c�*�����x`\�r����[zF/��g�d~�oy,?�<���������x�ay*'�ܑ#�A~��8��T<��7o��@��y��Ax��|�SQ<�5���`��Y���X�L���ĕgp�ܗ�2�^Yo���p�v�����v�ެᘅAcj78�5����x�^���ㅍ��x�u[�f�vb�3����v֍�6��Zm�nl�}2�tc2ƶ���:2�V��n}:�WC��n��:�e�p��C��ٸeu1�ێ�t{�Z׶_�p����K��t/�:�c�#���k��r<re9��.g"�Ð��K��ʙ����:jմNZ��V>k�U�fݲJY���U��[���ƺb�nX!��t���R?��TGj!U��G���QӨb�.���ꦲ�Z-Swj
5��A��PU�V
+U��J9���Ji��P�'���IפfR.��TI����<�^*��HO�^酴Aj �J���8]��B5���Eh!4z���A��TP%(T���Fs�^zޭ;d��El���W��.=���uu����.l�.����
���[�xϭ�۳���7���ڻ��.����j���8�١���o��n�m��w�	�k�������Z���9��~��m���v��/<�r���s�������w\��+�p+�n�/�go!<o���z(d�c�P�r�ӳ�a�ߎ�f8��ǻ�����oq.�k�v�qp�z��m�Ź8�Vk��m}�v߽c`����;HFdc���ΰo�[n�[&�-Qfk}�/��5~�������Yx5�8߭_=|���:m���i�Ns�v����FC�gh{��F3C۱�a������h���D��a""""IAI
�9Q���upPj�n�,����0;��$�"$���@���, �&"7�,��l����EA�ې��v�m�L��.޴��b4�y�8������W���t�T����xube�Ð$iBy&'��M���k�Q�`�C5ui�qcI?3�=���(δU��ʰ�-��P�:e/:�hY��!ͥ���֌�чMe��4ު�����@d�g	������A�	�d�e�.��6�ϗ���(�-��؃��v�~&L�r�e�����w҃8��GKh�	�m!�U��[�����U���]��5@�ɘ�(���D��k����Q��e�Z���-_���~2C���� � �9`�_&�I�ɵ&(�er�&���u��+?��|t�r���v���1�v�=@��/ta]$l�m-�^h��^!�����à��q�m9�*��$�����8�p>���XҺ��E%K���_���"W��
�̹d��L�-�З��	�D�%FР�����+xAG$�^]O������aG��������:��XZ9~��	���ݿE���"�k�Y:�]���{!�(�/�` M_ ��h-A �M�b�A�4z%OM�r�l]�-�i�e�ϼ��u&��w��o�ւ?�c3��JA�GHM)l���4���c_�o<��j��z/��x��.�껚����ēx2�@���3���^�Ͻ��>���#m�e��0�[]�~��1z������+^Ńi�K�x/��]:����a4Vv�g�/|�_�۷�U�=ڿh�����h�Ko��l��W_�U����S��/�"�S5 ?���^�>���Gx��k���w<�gi�o�6��3i��V@O=�_�R���c�����+�������Ao�-<�y��~�Q�����M��ٛOz���C��}��+������^筏�����Mt�v�l�W�i���q���8�N���N�x�S��u�雮�~���%|�G�{.�k\DK����8S+i]�C��W܊Ki��lQ�����-}�%��;:�+���I|����z���=�+5n�9�g������,��� ^ţ4�o���(�ٙ��+��tH��L��=���݈��������=�zf_�x��hJ��1ƻ8�Z<Cc����z���e�z��QiJ�l'^ُ��������d�dq"����E���3��!16�8CnblldmnijW��Ɩ�v��递3k۪����Y;Y�0�`�ay��q���ދ	/�.�\L��QU�J����J�e�njk�L��ނ����Zqa���Ԕԗ���2*r�P�����ϓNnN�)���S0� �MbSTS��'`��@W �&M�0q�]�%ܐ�$aE�;Boć`D��q�%ēH! ��L� 4��և3�<4yزd�t��@�Y�L��d���'  �e�����4�I�K*J��-Q��H1�����=Q�8�䌮�<i)J,rQ$���ѕHr�l(ih�,��a�+�!K*t&d$TAP7�*hB��0��� ��G ,�!��
?o>\�q!�:+XUh[�{��&�>b�X2=W=��&���%aGBO�+��c��kvFw�vxv�@�� C�|���S'Lg��-RrZ�Z��a�k��Q*��j	�������{�!����J���Z������\鼮� ��xM�=z����=I'���N��s����-��%���N�hk/y�oҏ��?���?�B��{�o���6�&�"_m-֛���ZE�����Y�u�C>���Z����i�F�`m��ZBc���=�<M������n��)BCvc������|Ώ������W��7��w��g�ŗ�(W�P�؈m�cM�H��w_���O��O���n
�힞�pO�k���~��}��A>���L�������=q�J͙V��u[y�U�ofle�Uj�	S3/��7�᪼J����e��n�wc��z���n씻�)�`V�A�j7;eX4��hr���b�4.��|�Y_>/�����xA�jĉ�}�5H���"��}͎���%u �%�1�.TB蟔.)���������Y�Iؙ���i�y����<8�����nz��j�Ѥ�	�Y�����i#sD�5���!�-0���J��'��>�������w�Z�I���d�;�i(�P�QfQ���t@�f�s2ol��d�w�;$�$s$�D����1N��919Y����&[�$6�j�3L��@`���c�Q�Q�����(���q��1�����b��b�Ŷ%�����Ȇ؃���%�;�p����ȐK�f�Y!��G��$��z"AD��d�A�����A1G�P�0A2�؅�Ƃ��2]p������5���:��?�E���r�`�#�'�2"���`Hߐ�!Y��}"��}k|m�~�e؛"M� � � �zez���Y� ���ˁ�-px�t��.�n�n�.
��sI��s�?�~x}���)��w�	'f�ݶy#|�z�tc�ƥ��M���	66*=�z��a�c�kڵk\��R�UIK3�v�ƇƄvzy�w�v�����
v��YF��N9�$�@f�VN�f�k�:X�bEb�a� oX�����+�ל	6k�����ً΋�벋��
����5fH��`�j+O�41�bHjU�(�|�*'ɫ�[1ߝl�11��1��.��ꔝ�ʒe�4K�SS2���o&x;�vc��ȗ3_�^�xi�4e �������][�S|�a|7P�z�B[¶�Z��V��R-.?���D�j���5b��ٴ&y��a����@�B������9T��WovMW�S��*���e�ì�4[���P	A�; :�:��j�N��c'c&gf����1m�����2��V�Y��w�f,������m�
n�OE�v�{�V3���.#N)s�O��d��[������>�M�f��dX�-r�@�jI�TyȪ!�z�5r�Q�
`�6;���X]=�R���
`���Q��U��ˋR(he%(��rf/*CB�����Ȳfa�/�
ѩ�
"։��*��[��jb��)p��"������,`�+Z��KoXx3�6V��x���͞=M���iPb�B ��'��E.�KJ{��3���Y�6W�����B^Slcy����{��pU^�L�[�2W�.��`r�p�l�g8*�
��;�B��s����s3S��$�,V���W�Ͱj�U�x�T*�5�Z��h37k��G巬���V�ʵ*��X�bX)��*5gZy��ihl�W�����-W�1&L��.W��R���2�����h~��ʫ��y�X�*�%�Ln��m���G�\��x'[��rN�W��bnf�ڜd�Ŋwb8��a��Ջ��ܬ͞�߲Rf�[E+ת\&cu�a�2 @BH��v�>���R�A��.C�H�QH�C�_�{�����H�w��B���b�cR��?�P��X��C��QV����8(�'n�l�P"�/v�^�����e�O�ܬ[TZ\۲d�dx�ya�)���8�1��/�
�(�/�` }8 �f>0�N:1du3Ⓦfdtk����)%��P�u�g������LRR�.nE�J�HA���d�@{dT`bЦ�o
�S�t�$�O>�xx�2��kr_��#�T�͆_���`ˑ%�m������s��w�S-�w'ΰt�-}Q������w�Z��3^�nGq�6-|���������v�
�J��w>W��򉛚0�sg�.�,�3�׶�$�Hq�5����}I�,}^܄>�������1󹘦��[H�)�Z)�,�_��T�'h��b�Z�V�>��~�_jۡ:f�!�"jc~9HVOu�ҋ!}a��[��7_��[}�����=P������*]�};;6��۷fǬ��ƝU����$؟R�(��(�L�4Y���Ġ��'�ݏ�r�l����q�Q˒�]c��(3���0��z/`�d]J_EZ��W:2�M=�M�X�ĎY���e�&��6�(����7tn��;���F���vT�ԙ~Ǭ�K7G$�+��N�z�"fOy�Pj��s��/VK���T���O�����˶G��U$����I'���������^2ɦx)���%T�X�[�lU��B�U�ok�xY�j�8���2sn��`���>�.wb�̱Ylp�=%:v����A��\��dO��Z��D�A#�����x�����ӫ7
�}�%$fA���l��-��h�$���L��V�����_G�:��loXd��t�̉�m�؁�d�r���B{�K/�9t�����0Z�'t���L�]Ft�_����Dim;Z�/��<1�������� �e�����ß^ V�F�K�Cf�ɤ,tu|"��G��k0Fm�|v��4��8�������ߟ�!���Y���%Y�Y����S�㜸q$�:b������qd�_�6�����EG��"FVF�mk�)�6[넭dv�\�Q�8���6�ȃ��a"}U�j4��9��x)HFŒ�鋘>�u5.�Ab��;��iU�����N]N����J��+rl�W�-տ�����,,J8=�e��`���G�Ͻ��o1�l��f7�3�F�/�m����B�Uam�c6���q.ͭ#���u�(Ӆ�O<6I�
}�e\�Θ[�~�X�q�����N�_w���N-C�р�sSuq���k��tT���TN�i�77B3�oR�$.�J/��P'�Y�u<A��wx1`�'�q���E����i;���Rԓ٨8a��h�I|ܳو�끳�����Gw��x�Oi�5�:/��<��w�E\��/���=�
O��Y휚a���f�j��KL�˵"}�����)��L����\����DO�>ȧ|Z�tT��VϨS�J��b�=���r�Z���@��h���$&�X��^ >�(1�/+�9Ѡ0�B��ˢ�v�@m�@wO�ju<p,]�H�K�ÇӮ�������O-f��	�C�	��N
�^��&�z�q0h�`F�	$�-l�B	�=����a�0$ D)eF$�	(�	$��3��v"�H#H��A#ۘ�B1`Ӌ�J,!#MP=���eL1[l����O�j��Q�SV����0&���pmTtc>�dL�$J~q1��%�jh\C��T�dl��=,��D���/*�s~��q�R����f�a·�ަK�X��Bj��F
�$i���Yk'$~�<$e���t�+}��Tوs��ӑ�B�ɕ���[W�A���p������@�֒0�C��	�@�B��t�V��xۃʝ��͸������]�������h���v�ר_�Ԣ�n�B�_U(�/�` U= �d�=0�Nc��|m���K�6�+QB&rW�ڶw�x}j�{�:B+��C
�yx0T�����fS\N������-��D����5l8���56���7fh��g�����GO�]M�Xf9�&�6�6(mm�
���7i��6�0^~��m��+�ʂ���ɺ�,�u�Y�<�r�ِ��I_���?j��F^����yy�N�`���Wj�`z��i��C��3|����m���#��М��g"�k߃�2WSLA�-ֿfD_�~�٪_�|�Y�Wh��y�dA����ϭ܄Wx�ug�[��&�g
�BpO�bW��S���0�g��g}��?�<������ɸ@�c�xg�<��.�bh3Z�����,���	9BN�)"zU�6�6vT��`�N�ȍ�w���ۚ�#��5�\��������j]���{{���ɘ�A��*�Q?}B�����r?;��+wC&ҕ3^Q����0��Q�"i�"}��,v0&g[n�:��:��o���&9�6�5�#P�wRF�ւ���8poѭқv�B�v]�*��������E@����T��X�LFc}�xX<�f�A+_eejj-Z��Y7������O�5m�{���6u��&�]V�N�n����;:;]�/ߞte���M��EH��F%��2*S��W�$~�ȍ��㞂S��܎]nޣ���`H���Q�m�ү�n����+_��m�>��<��d�z�zTv�!+c���� U����9�n��@��N�Y�����x;ˋ4���o�2��'Cj/��q讌�-���׻g{��W>�s�{6Ν���X.'�(s��=���#�J3t$�n��M}�Gy���8�Q!�њ�rf�ߍ4:��DDͺ+9ឝ?�y8��ה�d�@�er:Vz���~�"�h���ɘ8<�ZӬ���a�`�����	��}1�fi�ס�5�(j)���bO���@<�1~k�"���8'*)޳��:9!nLl@���,7�Fej�?�=���F�`�������$�}���7O6|rE~��W����Cy�!��&GQ4��tR�J#/�2vD�1tz����!����\Mi�u�rz�pX��ԫx��6y��r���~^>����>�W�\�&��*����}��ӵ�W�>_�+!�O�������
>�ߛ��<��zXW����'��i[9� ��]��@g���G%A�j`~k`>q½�ע�d~��*o���ޜa(/l�F�&�L;�$W!F��d6 |������Pt�[PF�Qy���^çN�|��m���vW
��GO�_?��6	�J��Z`w�s�o�e�Q��Q���;�F$��m���_���]Ф�&��d���2Wβ�ĭ�]RU˫l�K�ăh���}�B�(^��Vx����o�%Ě�m�����4&���"V��I���f����j���ٙ�8��Ĩ�0�323"""I��P"!c��@�8�rC!�(B(FD��I���ka�9���_޺cA�����,mB�B����. Y"�Z#����-�u��~����Y2J10 �j�	�QPDHE��ڑ཯��;����'RA����(�K�;���h9�GR�s:gP�WBY��o�
J���Vh�|,qqy!��'�7n��^aS���Ñ��E�b8j*���=�F���19:.W6����.b��n蓼v��|&��$VsO�o��{m�(؅��oF���) H����X�|s��[�-��`��->v#� �t������I��Km�@ؒE�L�5gT�)��Գi-C�&
5�7��iӨI��w�~c,K�}���-ΜV�B��r������]�h�F�ҾU2.p�}eo�p�'`*�54���pt�exAP�P���A��/�ud@��ks�(�/�` �< �j,9 �J�T�����v��4yB�<ݻ�H��K�ǀ�P��U
��l�a�{��}�v��hwmq��R��%P	���Kԗ�y�c#��$���3���"E��uu���i�_�N�ʷ>�异o�ԧNᷜ�˽����k�����BN�X���s�G���cf����PV�R�Z��٣�\�1a���IVۉ&(��cvq�2��Y�Mn��)g���{�
.�2�oӳ�c���w�j��t�P���Q<�opB{�LF܉G"W�E��j5��s,l���Q�VF���1rbH�4���R�QW\B�)��}���*w�ёHc��/,RZL�Ѫ�"�U@\���^sh�_l�g�j���x��c|���P�jģ�t� ��4��I٫�:�#{huzo�zvls,�4�R+�.�wD�[�-u7~�P���t�r�F��L��=!��A"�ɡuh���6w{:�?�ԽLVћ�q1�d�ՊD��r@15����!<������?}V���K��!�鐾��X?����+��烹��'���OO�����<3������6�,o"� �b��컺��{��ɹ"8���m)�'��Ȱ�����|༡�JU"��-����r���"bfS!��7�Z��n��ɬ�*xK��O���c0�^���^��8��W��Ц�5KYf�2��б�	�o�_=�z������J��\H۴�4�/̿��t��IK�b8tȾ�f�ӳX�f���'0d�+ֽ�?�oGu�H:%��4q�B�kPK��iw�j�NW�L�O�sְϮ�(���L	��L ��ק7��r-)�����|t�;���Ly�;�<N�}X���������d�5�a�I�u����^���|Y�V^�K\��[>N*�Jʎ�W�GJ��)����9��+F�pj�W���ΰ�X�_�<;��5��a>��T�`zӵ��}r6�OgzлiOH�-x�4�~����.�b/�<�ӥaF���3G��e���|�y�|����.���v��w��|�p3���L璦�����T-T+��n���k�-:��<�2�Uo�)�|�2t����J��3�8��<�)x�Cb�jR:45a[�4׍���V��F��I��������A<͵\u���������'��n��~Ӣ�3|����!�o�b��]dG�"#q⋅b��)͓�a�g���S�
z~�m�v	�<|ps�b�⨉"u6KU0�Nb2/�'�#���yv�K�4_�Ql�F���"�#sk(�8�QU78�ɮp�mfm�e�c5�0�hvX��Lű/=�	�"��0�D��z"62�K�l�mɬ������GQ9dӴG"9mߎz_L%eN�D?7X_�N(a��O��^�^B�n�.x�!�Tu��{y�p�9`�^�^�7���9_�r�M�� 3F�iNmsj�������Gѕ�y�{���� cG�ͣ�K�2^�k����Eǎ<�TV�8�(���d
,�7�B��w�Nv�O�:��{�1���l*GD$���� �!ƈ�����$i@BBȱ� �(� d� !c2F!q#C�HH��3����.�st�������i��b�"�VE-���`'�S��o�Y��rM����j���w�՗�]�.PH�Y�j2(�݆��
�*�X���(�٩>�(���U
H���~wt�1fA-p.sv[qNd!��P��3�S�a�Ѷ�U�L�ږu�$R;	��p��d���a����pB�Т5��~s�ح�4ӑ��V�k�i���ק��"�����NN���=B|�E1Cޤ�]�b�`ne��z�$ڗ�Yxظ3��)X5yڭ��p� W��_UH�	*��]:�=mߢ���h�e�.���@X�5 ����<���(N޵�d�f�zx�T!�B(�/�` �. �H�CP^Rc��m�t��0��C��vܣ@6#��=?:;�y�lbpLЙ��Q�,�Ƨ��dg����� � �.���O&r�͒cJ�ssR)s.+�3���*9��J���p7U@4��o1��I�}5��c߯L{h�������à~4��l��0�E�E��%��^p�����&O1O�$�h�iL�8��`0�i*�T)���2|���)��QN'�l��nCo(��n�=*tc���4��ZU����^��]��Z:�EUx��zͰ��X���=��t�ٙ�9}h���2t9���[q�]��pI�i�WS��$�KUx�}�[�iS���m3�f|~|ḽ��q~�ppP(���t�AD�TW���+y�)V�U�Ej?j|~|kg��X�Rg����Jcd�2�B��9� Cj<[��]�x�6�..�#��٫�.��ogf�5f�=W-K��"�;BgG��C}}�`�X��\��*�eL#{�	��?\�N�������hG�Fo�b8��!�*��I'z�מ�q���W9����-�v�>U�jze���Dz�+-�Gj���0:�}�\oy�r40��3�;����Q���u��@?��W�� �@/o1V�dz���v�۳���Jo��U��'z��,��]p�����#���C�w�J5��Z���6jw�J&C��b�Ԡ�Y~�=\=T܃fϦ��|>�C{�k�i{�:���'�a���F �^�Jz�*��m�uL7��j�fQ�U9���iANe,V�n��}�͋��ox�i[I���h�e�I�FX���+���2�-#���!@x ��l�_�}�ul��zN}G
��,/+#C�x������2���Ѻ��8��y2P>����ǣQ%D�9]�ʣ_N�NI��	^�~t/���>��]^��D�ݫ'Ч$���(^�L�$8�[�d����/R�0\�Ҫ������.ßq��n�ؕԃ6��:�=��{�r�^ڬ����no����u�mȶ}��F�z��h_�Ͷ�6�Y{M^h'����co�6T�װ��j����,9����o��(��'{������$3""��((L�P!#uD=@�DG2$C2D@F	I$�P��G)�(L�}��,y�Bg:��H��Ρ�3��ۡ�x���-���z@����Z?�{(oΓ�i>�k����@�&{Zq	joY�ov}a:�$���cQ1��Ib��)�K��JB��
&������_|�.z9wNY�v��&ּ'��m����K�:���`\;�����H��^�J���Ԁ8چ�S��=!E�~�<�^����Vd�ѽ���S�b�3��dV����em��) ��<�K]_`�M�%K!:5�9�_��f3�d�ʚ���Q���w��@J�*�����|����V'S�
$��=JuW�ޖo Z:��4	_�~�[�\�����H7�YZ*�f�(���Tخ�>���-��#v�z>J
(�/�` �; �f�@0Oa�B�VaM���ח=�W�`km�b��Ly~b�HԠ!Fw߇wѐ~6w���c���[dt?O9�R���|�-!6�a�a�ǁ5�-v�[�P�:�wz'��L��O�6#HV�6������<y��F��*S4�>�/�xԳ�v�O�����������F7Kc�i��s�Y���7�#�Y%D�������;��#j��8v�\���'-�F��m�n�_���r�����tq1�]\�f����s���?T�s�j��УW�M��q-�w>��k�PO��_ڷ���{!�ӮMS鬃����V��>��L�~x�+U����>������}�ip�Ng:\�	8����Q����K����ؗ;��֠�����A��_���V"��K}���]���(�ޡqɅA����;�_g|�������_���TsKF��24���	wл
U�ކ��2�~f���#in��F�}#���]5�vw�)d���!�~E��Y���]�nU�G���x���z���W'Gj��nK]�jʱ\��U��l[�ZRwg��p�
%�B����c<��_�vԋ�v=�!L��(�UZ�d�y���IP�u�����u���g-X1c%�S�p7�[��h(]���ަ#BGD��t[�PXS�+��6�F�s���A�h{I�ftږ�Ҭ<ʮk�9Ȝ.�r�i;vS+:����B^G�1H���z���rS Φ�Y+J�P�ÒE��FK͊������Ա���'�=�����1H�e��O8;ɬOd�.�/�g�26��xJ��5�RoR'�o�1n�4���F�2�D���>�D+NKIR��ܡk�m��؅� 9C)�I�ݼ��dZݰ��@ϵ���m9+��Ts�c�l�A?y����ꖵL�0AR���ϧ� �����C����"/���W��4V�_�K����1u<&U�o�q���gl^�g�V�y� R>3v%ZYuqYY!r12"&2Ə��_il�JrR�,r2���JQ;�Sa]Q]Z�r�ܱ��Ѕ�Ѩ�s8S_��nJ/�2�?�׌�9-LK��b	ua�8�M(���_{��:9rg$��F�j/�+�n6)\"�0P�
fX�U�l���~��Bl���_``[�Z��
T����g<V�(��~�`
Ǻd��6���R&��)�\�5|���xJ��?S���n>�ߎ>hΊR���Y�h�a[qR����8�.�>ǁ�\�U�H�[�lz��R�t>�I�&��B��S��ԽYI8��p'w�	�vk#�O���Yɷe�@>!����rP{1���)��J})ߟ�@�M��)���V.v3��:�ãSIn�!����)o�{���yZ�6�J��;�.�Y��5�$,�q�gغ�G�|4����!$�X#K�K���<�K�F��OVٷg�.j��\e�Hb�������rxY�m�za%�Y��NҬ���L��Q���nJi|�S�=@.1�H�p	~���a,IRf$�$i��	$����BQ��C��1!3�P@R4I�{���s��Ъ�'�#H����輻���XbiSvQD�&w��ͭ�D�Ŕ�{)\:2�cƄӈM�XSM����We�:~�����Ky^��Q��\������ڈb]�8	RD��$Ë|�o��]��x���E�ӵR� ?叿�M�E��A�,�U�q�f� �}�-Qd^�qB�$}��Uh4��c)sX(�J�R8�2+�d,V��`5�q(+E_21�w��Q��&";�|?���٧M	�J	��5>pR�a��w�t��G�#��I��J��H&�s��D=�){�"�hb�ѐk4ܙ��@����ӵٰ�:��"YW�	ǔ��(�/�` �7 �_D>0�R{�9 �#'e���w�,: nI��W^T��h�?34�	�
�����׈,���mtPXNu\{�M�x��i�d��^�@Lɳ��O>�:�����C��>C0�>�5\��nr.��K�c�в^��0<�~��x'��Iȝ�S.y�o�H�H��zԳ]�=�ɛ����p�]���9kk=<�n�۬,�5kg�亣�Xoau�ֳpIa��9�J���x���O��;��O����<\*����|e�\c:�>+Y��gD͆��Y��&s� L���TX9mɕ�2_��E�F��M�y|Y����5�c^16�L-N|��8�X�����S}���m�m`Ƭ�,%����]��a�k�D"�$�� u?)g�(wc��X�[��a7\���Mߍs �j�;-�*T�͝)�B�X��HX���F�3����׈�3�Xp~�6{u�VN�|�o>������o�\˔2�V�:��� �s'w���߼V�qc�=;$���G�]���ম$�e[��@[����`H%ً�<9�#�蓎�5|򗁳�w���zs>b��}��������2�Lu,3&8�����O/�_X��W�}zǙ7D�A�H�{__�v~�U�4� �����<������`��0�Uab{ɾT��:�r����[�e�3egf�i��-�tv��ufѽ��������p-�r
ޥo~T��ZZ-tI�&Ժ��*���O�6�7R�U$���#�`�$���5�J�w��%E�r�7����`��vV�rKڠU�ZE;��$!27Ǧ�"������
?F>um
G��S}�o����ֱ�����^�L��'��5sm��GI���K���5\��[yeӑ�v�]-w���V�W˻q&�YK�ֿ��[�U�{��vpu�փA	��ղ��^4J6��	
��	nA3��Ro�:ԗ~T�b_>ēW�j���;�=�K�P?����c�W+!�^��|����+����1Q������~��v*䏎�#�a�����u�G�.hd}���J����!������L��(#d�ڏ08��F�F>��u԰�7�^U<�""�3��&B��^P��]ā�1ѡy���s���U�
	�
��'���BV=�Ӻ���
QV�����K�P?ᙞ��Zq_`x4�_-����b:��bV��	��WH�e��-��3��kyY��1� <�`4����)�{r�š�zbiB���Q�Kz���3M@��Ĕd~�-E����2/�{�Ա��k��\�͙��ӫ/e:��\�w[�<ٌ�!��y�Ow���G/��;�<u�/���� ���X2�*ˎFQ�O�v�9ٌ�;=����(k��>�v�-���������A�[kc�hZ�h�3'$E��״*��>�_���[`Ɓ|wF�(�~3����$� 2�L "#��ipB�:S�-B$%0� ��"J ��HB�@���Vt3�-"&��`:��蜒#>��{C^hR�Hp�	�CB� �ӆ!��N �sl�*�N�����]�9K"��
n��e'}��~�m��p9<OyRV�8	B@�P\ރ�;n�^k��/J;��0~���(zi����(�+`�F*�}�r�dEu" ���# ������#(��"0�ք����d=d1��Lk�4X�����ۃ-�wL"^�&X�����	I  �O�[�;�͟y����L��S��/��e@�� ��6��/j�ʆop�G��*t1�N��Hڽxq�H���(�/�` �@ �m8=0bRc��}�X �-U��$�	d�}2��PJ ����� 5�����h~]�0���u]\lk�X��x����_�kx�bv��K����OP�o�OM�w��ؕ�|�]�W-��"��K��8�9��cА+�����O�����P�٦��l6�Lk3��Z���9����Sq>/��l�F��RC��_�F�3�����>�^��W���%(�!Q n�a��&�L�ƃK��N�3Ϲ!]�`�b����T4�W�Oʦ�����0�1Z�� ��a79�;y��KƆ�ʬ��e��
��!��YE��T�]��ݛ��S=yhh��m���_`�Zh�(k�x���-׿�P�ik�M�W�1/�6�m؊��:��mܰ]�'mc|Da�8kyU��ų��t?
�<���qz��:*�d��e�VR���a���,u�F��'�c7T�-� ɡE�$��I��k���2noojfŒ�s����<&�v�@tQ�}�ǣR�¶��)1�_ۺFҲa�EKI��'��ɾ43b�\���Jq2����a���ƛ�f�V���
��l�J�I��l�X� ϋAt�l��{�6�N�����ǽ����L����[beW��O�qW������o����꺺j�uj�M�7H/%���<�S烸�3Ƈ�FN��$q�G�M��s(G'Y�i�4H�v�̛zG'�hR$f}4�Dkv9����%�K�i�w��:��|�	w�6����E������x[y��p^"�A:��~��Z>�����r�xsԍ���چ��22��=��T���m{����)��w&�uP��2::]��/����I[0*[�3���.n�J��06K]ࢼUq�.h$��^1u�[�-��L��C�R�0U�Gc��L�(�blWEz��q�J%�x;����VW=:�!�(G�:1���F1l"h_�6�Uu+n�X�O�+���B�	���ss���h\���Ml�΍�ଓria�n�X�m�
$�u	Z�&�J\ʒ*lL�(�;D��Z�l�N���:��~��q�����`�H�n�>g��H
=��F�:]��8y� ��K;����[��R�L��%fS�Wnk��Y~��A`ۇxp�Vħ:�mQ.�հ:yeͱC-��S!DΖXm<���:;K?��krᢶG+ۦ�ũ�i�����io=��8���Q�O&���H��+�SG��Vp@qݖ/U�؞�A��ߴ:^�ay/�?M}�-*���l��P �:��@]�͓P�"�O5�e/�������C���
��i�W�5:��j8�-��8�[��v�Gm�`�V.3�y���<��?�/����� �Lpn[�䘼�qa��p�v�ݶ���A~�i�_ ��Nk�sVh���X������`پ>s�ha���I4g�u�l��K���������鹣�f=�Z��|����������\��:�w������XfY%�Py,�u�S3����\��p�.?�Lq�-���W�����tOx�`����M_���Jhp㭻�>���o�nKklL�0���������g������L�%9�(nI�+����5&����8�B4""���0I:�"��y�2a'Q�A��b"'J�Rx��F6��4�LƖ�P@մ�J&Q%"b����)�TJ��	�p$ dy4-;��
b?�u5���u24�$z��'M�69T��ݥ�"�L�@
��#��=�}��+�F�wTǟ|�8�]lƋ��y-�v��p����*�f]�2�39���~����h>2��Z�Q>hc��%�$���ʓs�\y���\�Go���ne��6��J?��~
gέ�����]�D��W�؅7�B�$Z9$�3B�#9i��8}%`�"۾b�d
�F�t!�GD4��"�e˄�i[�+K�*8*�:迣�z�Ĉ]l�=Ӎ=�X2��2����Ƨ�F�\"ƈfCCL��	�OC�,�:��y�5�Zr�����mVJ��������jKa����g�dBT��ȣ1�*(�/�` U@ :q�9 �N���L��z��J�L$X�#���3�q!ΜA�n�+��hz�KĐ���%:�����}�z(P��6@�q,���p�u/�f�����f��O�%�atZ�������_@�b\1>q�f�c�೼�#?�C�����T��.Yᛍ*������\�[��(_��l�]Gi�.U��{EJ/Z��V�wԛ�=��ɺ�Zī���k��R�n�=x�/�ހ�y�T��hkS丰zH���iFpǞ���=W�䥣�P�Z�S��o2O���Z!b����"p�{��=U���kg�Ǒ�m>���r�׼xEF�s�±4�d�[����w��������Ō�S���BG�:���#��)G�-gK<E�ۮP� �ȸ����O.�9x�+]��y�+�w=���:��|�� �_^��\�R�Q�:�d��
�#s3&���qJV�"�Y�4Fg��-TX ��6b|�m��jC�L��|�(�a��|��y��~�+�0�Jx���������	�����6 ��N׋��d2ʼ�`�����i�8섑U�N���g4۴)��iS�s�MU-M���Φ�$Nɴ#O�K؝�4�St��ʗ��>� �Ʒb�pi�1��k���(;eأ��W�B�����W&�Rx�Mv6�c��A<x�Nh�H�;��A̛˓)��pl�	��O�j&��@ʛ��bL#�����f�r2�z=����H�*8��vm�w���/�����ٕ��S5v�}y��X�5�F�P�k��o��������i�XH���h�]OI�z[����ێpO��\�ڗ�rO�v��R�[�[{�4r멘�Y�DA1O�]�I7�E�i�#�7`�;7WǏ��w��gn�-R�,�F����K�ߣ�)��^�;_���|�Y�{sq��!���\AL(;e4?�Ԟ�<�3_�T%��8p������� ��)/�^�"Z}��-����Z��%{s33{�CD�K�rI{^��z��������W�	;b3�op+��V^��3�QnQ�.Vx����FКv;�� ���,�xSc,_\�F�J��E��R`���S�����A����b�<�4��!�#]UG�/��#T��z���G�g��72��0(?��&�Q�o{7���%Wǧ�8�>�/������U�f���Q�X�礊g#\����r:���}����/��0�2�·ݝS����n�Ą��1�+S8#1L"�2����b�8����ζ|*Ɣ'ҊbA�O�����י�+!��L�~���0mc�F�جV@@���������=]�/��#1����vw�X>�oN�#��$�:J��foFv�7��p��[��J(ũ3��-kGq ǳ�)�$�W\�>�z�RK�7�7�M6yZ��']^Fz�	}�CM{����;�햷�eرv3M:k\�z^��a>ԛz4W��<�|��d��燹̕�dF����;cA+[�R&I��1ơ�)C�T������a�,�)���[�@��m
1J ��E���΍�ZH���2�>��"��M�e�J�4F痽'[�پニ�f6U3Ӓ�^q�\懋�h���	ނ���'��F�O:��Q,�'�ϱ=OO��F�'����<����$�2"#""���$m`"������8� dA� d�	D$	F�t�c0�)��4�Q�#ގ{F/���m *Z^R)5�Γ�Y�S�Q�f��NوKIW:�=p�]@��ʓ}�9E�����)8�Y$�Ɔ�����D�y�����!��H4�!���o��}E�r�Վ�cf�|�Q�U����D��(�=��t���J�rD��n�@�rA �N`��O��rX9��s�3$[��狛�XH�H�Q(�)��lY�' ]y5ȝ�Ӽz��e ^������I�T�ތ#:$�5z�h�v'�w)����� �ؐq0����	Gzg�%͊c�����|\�rU������؇�%��� ��(�	�Tˤ5��|��1��z�?j]�(�/�` U@ :x; �NHF,��v��8h��`P8 ��C�8��2�&���W��+{��M#���&+K������T�}w�z�U�"�:��k�C-l���O���Av�C-,O�پ��x�*s*�5Nl�-�q$��y�Qs�W���,¤��]<��V���Og0.e�����pQ#>��8�U_���U��>��>��e.�`}�9EL�M����Sv���2/�Թ�Gqh��a�`N���/?@�67�5&���w�\p�����v���~h��ϣM �t����p�<G|>W��{=N�Ƌ0`����L ��!X�D%J���'P�K��ш6��d��"�a����8Hw�.Oݕ�%oJ$I�$i�t��t��Ʈ�M_��I�f[�G$�+�W�|u��By!�=ƞ�2�t|=Q�+ޓ}ߖZܯ���ɼ���&��o;���e����ρ\_Ϛ�o���@ٳ�?�����]8R��:�lGWex|�N~us	�J���n�l1N��_y\�\oc�\��T�:�©R�/j�ʹ�8&m�d���k��딞<���]���)�	��HO:�h ��F�W�	�P�+�)�ib���b�\3���V�Z3u����<�0�׿���@2<�`��@�u|u�܃����K����H���=m��5��7�@�8הkO�$Ap��]u�g�ǉ|�'z����PT#Nl�6/�	ȼ��ε\�Q|>��RpH��G�]~�����Rm?~DR�'�6���1��Bě�)��&�]L�}{I��M�F=�u��A�50������ij�R��nX���{{��7���p�c�v�f����-O�B�EP�~�w���CDq��x�P��/��K{�m�`S��mT��\���O���u��%Aj��.�����^�Z�w=�(}Ű]>-lkJ#M��c�P��`����A�Ĩ�p�ݝ�9�C8�'D�׋hz��rB�P'�"�\�*.�ے/t-���no��H���u����c�V	��b�;q�~������a���(�^�&�K�t���f�6�Z�ࠟ�m�K�-'s7Kg�u�}C�}���*;�i'��k)�_ٜ;�ac�'�v��-��k�R�/ҕ��?��{�Ǽ�J�Og.v�Z��6��M��1O�b��t���S+�z)o�3*���.�hK}����@ꮗ��ࠟ�࠙�������*�c�I�S��L-V�v�zq��)ӧ�^�cF^X^��1ӵg-����J��a��E5��փ��Ʒ�x`=��񧱢��Bq�8�C�瞽r���Q��(	>�HA1ϕ�)x�:�^a_9*Ȝ�T�:�j��Y���5rT����r���ٸޖչ��rX&����*^�м:K�)�c�:��9-p����O�e���YW�T��;5�-�l�
Cz�N��K]O�wr�٦���_�4|�H'�^�����[]´uK%��%@������ ���]�[�EڕAg�_��%|�Y1j�H�p�_t7W�q~ѥDiy����8Cr��g����-4����qj��*C=�Q���l+�S�t��EϜ�s���cH���N/@��lY��G�C��BP0��Cm��u����IQ�)��{�T:����=��*W�t���ν����K�p��I��F�H��H�"�"C���A҅Oy7�,�B�ۢ-��GE�c����)�̠�A�|d+�2eO
���~�PM6����i��/yf0 4c��{w��,(�1#�H8���p;�`�(�"��0F1�8�H �MD����ç��i #)�%g�##� h{4��IATb���׹ �3��+��YV�k!�)J
�β���.����>.<�\RF0&�h��q�T����^�DY��n��C�C��reE���ߖ�ف2Qs��-?�]�H�C���:հ�冇-J�x���"�VϺ��E��4�3��Ó�:���m�M�6N��		o�w��}�C��? A�,�B��KJ�{	��]�!���j�9`�`���{��FYd^���N9�ܿ����{����h�6�V�(�/�` mH ʆ$O �RJ V@�t�y4l͜��Q��;R��s]F�\�F�+T��)1��;���]!�����餔����{��-�3�/�������I�e���ib�ѩC�����
��R粬Q�H��RrV�ѽ��T2�lő[k�}�)$[JH���&aG��A��ո����s��h��.���ѯ�!&&Ǘ^e���0��1�����oD>�_�7�$�&��m�B�xT7�HUPP'��z�d�
�+P��lU�[|%&b]M��!�Ѭ���x�5*;��_��4=OzO���۠�S��E/��>�Ĥc?�B���ϨӅ�|���8�82���iP��E�JxT$sXEA�`����(�5tK�{�8v������?������C�W<��vy�-�D�w������ ��x�@o�	�6�NҰ�S+��#Q�$�ڬ_��e���@N(_'��2Y���#�=�@W��ײ �_h$��+��a����hZ���:�嗷���@sj��֡�BN��{t~��~�������������9���	�?��@N�U�)I���Z���# RĨ�U��d/(�	{��b�߶��_�k�������7]P���"�n��`q�:iM$¦�0	���e�=l�!'Pq�@��r�A8��"K�m���5��r̰w=�&��Ԓ�j��ء�;��ם0*��%�c��?ϊu�}꧆������X@v��B��EK��=�őS/��Է�(�m����� ��Dhs�btI�2�r�7�=��q	�� �|��x	�F�}�f��1�'�y1\�)��Jʥ��)]5mJ�U�jI2Wi�4�&z2uBAR� %'�	S��FX��*`��f
���Z�94ԯ^����&�ĥ�x�φ1��̗A ��FeK�Ɇ+''UT��u`�뤨�]�2�C��Xjuo�q�z%8��w��֨����F#����c6��k\Ɔ����(0�Nu9ܚ�f��~�ؽ_�0���������q�c'�'���aN�X��-�A�C�Ny�WF�ub�ϗ�y���A����{Έ!g�����6�FL�{f��h��l�6���>H.�#�?��(���̀��'�v�&�v���%Y�SoGK�#1W�wƄr�<�T��$�������>4h���kA��lI֙�ӹ��� 	x��Q�T<*	'�5��ՠ�B����y󁕻����!_ZUV]fo91z��g�����e���/$F��d��	�}�1��F�����fE
V�<P�����-o���vz���Z�1B��lNQ��|�8�u	��,��6 _�5t�י�F�? �*�Q�c��bxIS�)����Iz1b�#�Є���� �I�"^N֌|�D@���Fx�ך��1��l�ey1� �gG@�0zo�S����l�%����y!,��.Zh�����n���E�J� ,���E�&�WB�.O,5�v�YܴT�/��l�i�5jS�O���2���uA�T63�(U�ޓ��z����.S�)S�јT�j2}�Ȏ�H�ڪk��Q�
^��/�[�s�b�H��C^H�~�)�:q�%�����f-�zUf��z�:�l�.�֢�2*z���7}��]��L������!��ȅ�~�]8ʋ�ʪ��:e�$m
�ԛ��$�L���2�`�2���HWRP'\��	U�L�.�E�"<4�<�_���+����"o6�/��:�:HW�hL�>@1j�m^�Ѵc�s$'~��P0��(�v�)��)d\QR^\TE��L�:+���hH��|�6���2e��
oiuE1��5�`���p!1o�h`���b'"��t8�'��[�E#0�j��0sOP�����=|��;p�PPKb܈u�(S��k=����Q�.��	���*P��|��ƥ���,�׾0zn��ښ;��An���K�ŽS#V^珨��0��?�@Y�'����G T� "Œ3v��Α'���C���QDn�	� �5�bDf�@�P��8t� �����SX)���>T��J�Tm�
��k2�_A�Z�s�Ǡ�,�=�����������C�O�cߘ���}�צ��[�"_Gj ���;a�ڠ�+���*��|-}�%[��06�k����7�8��;���@������n�����E�j���P�o���z�kaKM:�A���֒�G���,g�ñ���d��pk h��r��T�8�7XO�R���l�r�l�Y�b�9��8��@a��s#�3��}��&ߍQ����'��&$�r�A�U(�/�` }^ ʿ�*N ��Ir������ ���]t"����)�ߖ�uPpR��v�ݧ�c�3*L��������޼πJ���1��4aYV�{�h	��_������c#����2��PP_-��uq6�D_�j�����&�
цa.�~�٫8X������v�t�3�@�u���c�x̩fs�������p���壚ygqy.������X�.�����5-;yf>���+*�D�S%{�ĺ��jb1I�=ǋ'���ǝO�T��\3F��)nV. ��޹ �G;���
��������5-�ꇾn�c���6�XM������^�'˧�2�Y� �9q�e����k�l�ĺ���^m�� ��ݍ��j6�V�\<1�sèW}�T�~�tpstF�b
�)�VC���VQ��|n`�9�
�R��GRТ���,T��qƠ�׀�UH���V|��ɴ�R��@	p��pD�D0���j��eaaB�$	5/i����)�L��^r�wa�����Cg�{�V�$�	F���%
�t���9�ۢ�=�b,)++{�A�q�L��E��<�|�ȱ2P���^��.�ᵾ��ʹ���i�n�)�~�b����N��T�#Lʼ����u�bNK�2��c9����Sr�T��+hH���/$Q��+W�ȁ�35&F�T�!��z�#��W��8�x8���m���{]�m]ۖ-UĴ���yyI�f�ဦ�]����y0���dK���ɭJQXat���[Qޭv� ��0r$�>�a����_�v/���W�2�X�"-���̀�*�z.u���e�X��F�U�I���F�nX�~�(�_��e�hF��mX�<��d����Ʃ�[����9q�C��UH>����{�����׭��Ĵ�l���L�[�]��d��jֱB5����i�����,ݸ�� ���Y���l��6.u����i+�:Q�ð�B;��~G6�F�qd��:Vx��㵚��@���o����_���s��y4� P=�-����اn��� #��0���"{b��h�%��h�����"��;��S��qS̾P!�Ad�Ӂ��U#��7+iX�����O�T#ˁ"�e��硹���P�da���q�N�ˊ��Y�Ԝ�\�r�����z�XG��qZM�M�~�j�L$�g���z�tx�茾E8���bD�!�R=l)��7@kR>�O�O�ڨ��e��>��f�{?�^��Q��C�<�됃�qE�hbb�E�^��t���n-,�x�e��u�����7`����w+.�!+��������u�1%�IJ,�m��W���N�Q�[t��6�f�Ȱ��qqam���2��V���R�J���B��'ʧzG\ZG|��7y6���<��77�1L}�L���t2'b��������Z5��M]k���W�j�}�>��R���c���.�U-Y�����d�ؖp�t�j2ԩDL�-���(�qi�G���OӮ1� ���B π}0�C��^�B9�A:K�G*#:�~\���v0���m8��Љ;Y4�GFQ�ٙٙ(�
 [���m}$ ��<�[0SYhD8����n�
N���l��(S������H�pi@ju:Y&�C��q#�tܬ�j�������F?��4��p�t�3�YZs�H���E�`o�	@�R�c�4�Y�4]@��/�N���?��Sʃ��׀�aS����,[����al�Y����E(�q	�*�De�A�rb�	$L`�����`�0W�6��y@�v���PC�e�.�gv�e��@��{D����C�N��]d�۷c`�j�9y�ʉ�WS�l�������'�e��,oU�z�#݁'݅b���K�@�I#�,��&ez�+5��ĉ��lT�CL^&:㔩[���`qr*������[6"a]� ��Q�Ӣ:6Ő��x%����U��V����m%�ڱ7/*\a�+_[��q}9+s�I.�j���W�/�_���})��꣊�&W���Z.M����� PL0QF��,)� _ � 4�J&9�5��E_��Т�Q�y�:i�<�0��I/��t�i�IJ�~��Nt���.��+�2����-x�;�L����h������A�_ɾ8�_ٲX�`�)~y,���U�4�Wf�d�Ze��.Pc+�%��7�ran�WC�cO漀]�V�r�i ��F��I�Q}CjE��G- �Z[��Ȃ��A�����Y��ڮ��*�HU�����̝����vYJ�c�V��v��,�2zvr}}uG��gZ�g��(	]�wZ�#T{P����y��$Ľ��A}4d�j�VՊU-w&/�O�mx�ӏz�ez��:����ǱW'��V�|�����/�W�4E�����4P�ruU��2�*���x�Cu_�_�]���Ůz���&o}�m������m����ڪZ�d)'�xӇ4.W��� �]vd�wa�~�_1�;:�d�j���W��
�a�q��n����9
Zy�c�����0z|��G��C�>>���l�f\��[|3xq��V^�`�--=���lZ�ӭ��D?ޯ�u0�C���C����.��*8q�*.���U��;^C����C�w�}�t��f_�'���6��y��zޖ��y)/���@jx��LM��%#���N�D߈j]�ґR��Ȑn�a� 3
	�U������%1I:Cș��(H��� $A����Ɵ鸻��	\�-�@ѕ(�6�W|s>�9%���F$�/s��PѢ�Fr@��$<DkM���*����
��=nwf�"\��U0�CZS	��Mɪ���]H~�X*�D���k�Y���[��<d��3$�΋B;:)|p��'�p�F�yogw�o��|���2�/1�"��B��feiHXH=ɗ*������3[_��R��!Զ���F�<S���5I���JM4��{(�/�` �W *�d(K SIA$E���T�w�Q~�Ap��G�'������^wWzC��:��{��W4\���`�X��m��	1<�FvL�s��'�7��#-*+L���As���K5թ���ꬆ�۫&�Wm0�@|������4�	�i�B;5(5���a3��������E�fj÷@^(O��n�h�7/�
}����I���$ �IP�2���@�dUd� �yHܰ=�
���/�.<��;G�?^8�MH�ꗗ���^���>��h5MS�}���R�qF�|�����:�ud/Y5+�T�[��}%���,�J��mӻ�Ӵ�ʼ���7���pM�'�� ��G/�)���Ц�5�h�b>כ�e6�s}��O�� Z��6v�/�5�8��Uh��l卭le[�m|���75��Q��ƿ}�.�z���E^o6�K��&���k�AH.�w��n�;J:F]�J=���]4f���1c�&Č
��3-;�xy��*VS�]��j��둑lہ*B}�����c�x�-�'��n����-g=_��vF�������=�p决�_�]�_ݑ�ef^]Hƌ�&9�ܮ.��G���=�ǝn �R�h*J�Q�ˬ���4�G6o~ �QO��A�pj��c�v�[��:}Ѐ'�T������>�5�U�������HV�;R^�/�5�B��u�p���F�+���%N�Ҵ�$K�j�i�w��o��#����.n^��@�k���;6d�9D�#��ď3(1d�����h����q拍�15'P�����TW}1�2�]3>3.bKR.��,�8�|?�WWj����a�".��9�ɨY���3�'nv�42�?���/.O�c�A}f�ЄFj���m��������'�B ^���Ap�1pc�?�z��pָqJ��Յ���z 9.���I������_=R)p��(��I�����#>�AGr;���=�GtP�J�;���h�W=��g}�U�ҫ��������jzZ(x�¡�0�����B���,�Ys�,�t��E��Tm9��:gh�I�t�KG;��&e�ь���'B>�1S$ύ���&��H�v�g����U� �̌LSnL���&o����$��w���V��R�0�X|y�B����d� ؂�#=~/�PG�n	��1eNƢ�M)�-b��8=:C%=7�c��an�wRШ�ȋt*XXd_^	j�i�e<���r��eת����Fs��ԧz�(^C���6g{^z�fuJ$@9?5�I?n��e��H1@�qƟ��W�w��q���!�ªOt�_�z�+�*j��������j�,�e#�jF��=lVU�pg�սʢ=��l��=t��]���e�,��e���Q�A���:G1��c�OF\)]�8y�$
&Z7�#Y�tɢ.u�i�n]N�q��i�ҬZh��ZS�:��k��3:���,�&�Ag��e]���ё�}p� �סv���H��I�[n/h2�#�<t?C������ix��թFbC�� M��z�C���eש���:�S��y�.�%�-����ޯ�9�ګ������_�:��y�Īa�k����թ��V���6�Ooj��A��$�87fNԣϹ^a�*�%l٠U� �����?|�)��rI��ɐ���#FT�,׍2r��д5�a�$P����E\$ʮ�<��j�y��\��
2~����=&�U��+l�_�Tp�X'O?@$���[A,k�'r��V��EV@A�
��m��
��ǚ<`��@��Z��mP�ӣCՏ�t��c3��L�|QK�i͔}��=
������F<�������1�0Ic2a���Rnŉ�'@*��-��M3�S92�!D�� ǅׄf�d�F=pݣFu�J��?9�Z{�X�(6��۲��"�p6�G��-�����i�ch�B���^#F�5��S
�{^�y�5�Xbqϳj���>k�9<�pt�k��O<��b�뒱Č' ��G��hb�h��H��b�d2n"Fa2D"̗a����D� �.���S��́��W�=��=m�C71���8q�g�K��D��{	ʸD��-h�����1���|2�x�!�����ʄU-q��	��j���%J3�C�xb� .1Y	����x'�K(�2�%$�O#AM@I�$�Oc�q(n��D8ć���×�x ` ��0���r�b�`[X�mc���yۦ ����9��k��zx��P��?\�tA�%6D�-�>��<G_b�W{fKNdd�U��ye���Z(��7aa�X�ȷ���u�Pk�a#�wM>'2���]��9��F-�DMt�6:��u��Ł�\��&(�{P+0pM`�֚7��n�o�����3���E����/ra����)�(R�HISK����:>:3h@HSCu��YY+'�ag>+ώb�f�"z�E�j��t�bPj�E��Z�U�vR��-MOu�^(���ѱh�ԑ�<o ��^�7{{n܄�YY��Y�!4i<%�P".W_�X>�ƌp��0�>���T�Q,!�D3є�����"2q��4�a�@C�3F`�c�(�`���_1r��7(�] wˢ�]V�L@���fׁ��+z2�M��쳼ـO�1��-ҁ�hM�- ��?M���%��A#8 -��XX�_g�Y�ͻFu��`_C %2��8���\�@����#K��--i�o�(�L���)˸
)�-���gy�I��]0�4p�(�/�` �6 :t/ �I����dG��ŀi��J��7��lʁ�5�>��M�HȖ)[fM�1U�uH�oX���?��tR���ڥ��VC\�A��JӬr������}�ǔNU{��uV��3�^�r@U�\�Pi/ڴmڍ�\��Jlr��+M�'�'�OX��\�����ep�*o��UM)s�N�[��=j�N��T�v�ب*�h;a�u[RM��n/��__J�,��(_ܴݬ�Zv�4����q��-�ʊm`�~�jG:��:�N�ќ�H�؆��oNX���@��,�����F=p��+�PͶQ���ۋ�4T�z�czv���fsY��N�YU��T�E%x�&�B�j���FM�$5nO�cj�|LW��[�"ZD�▍h�6��@���A��OU�x*�u*��r��67o;yڼ���[�2���c��ow���>�VO���)�_�$���pUB!Ee�:5��jA��PR�C��ةD���k��A�f�)N�4���	�� �-*SGf
yxur�O��m�Y�Z�@X�L9r��@�6.*�G���l���e
�%����p�힛�o����`ΰ�'�`��N�l�Q��[�V0�	,��܍�
G��F;9���6��{�������D��7|�!�`+/[��0�p?�m��p�Ov���=H�9��MA�[�q�x���AEPw)�d�MV��IvG�����V��/���U�r/��-�ro���*]����.�����*WQ�VQ�qI�t1�ŕ���G
���Nʋ��K����l�e\8�f�l�e�kV�.�X�}��,�Ϻ�M�0��`�p���z�.�d�l�=�E�p�l��?��.��X�\�M�{�bM�ݶ-�"7lѭ���׻~׶���a�jR�:ԟ���3}�JO:Ґv4��hCZЀ�3���g;�9�pv3�՜�3���b3���e.�\ȃ3�1����a�b��o��>q�G���a����r�Ma	C��/���N`���]�	Z�(1Dw��֗l�.]>�q�7�Sz��_J)��ڍ���%t��$tA��&��*�Z��^7��P=h���ؘh<�'�)��&�(�)U^D��3�۬8�pX�2!�w.�e�l�ŲW��VY*;e���E�F��6W�.s},�ݱ:�oo���[���[b3,ێ�؂����浮s}�Z�:֯n����9�iL[�Ғn�э^t�]�A��}�s��\g93��6�yq4+^�1'���wy�Pr���������-^��)��&&��=��5�a�m�
�=�?��v[��\6������{:�^��k�]ܳr�8��Sv��T�ƻ�;߆�ñ�d�lr�Z,���}G��:����8�g��q��y���y�q�,�=�n�Ξn����_���Y?�n�k���Yt/�f�,�Eﲋ+g�Sl��#�9���qT��"FDDD$H�d��!��m@�+�0�	$�@B�
R����raojX��j2��P*�4�,쟽=�`��������5��]#�Y��ƠNւ�݊A��D�<Hd�:m��7�51�j~���֐-��Z�M_��v��+:yu��,�u:��/Q�A�+;�a�����4*��
$���[����k���<�ÏWyѰ��耤�Gq�&�I�{d8�m����"��o�3�O�G�� ���"n��E]��?�fO�̒���*��M��dʗ�b�� �� �!AdK���y*2�}`�#֗� �F8�O&�T���ܧ(�/�` �, �Nt=p�Jc���t� ��y"¶s؈��Cjg��� �J����+\t� ЙI ��".��H��)� � � rn�4v�{�W�G1;��Hͨz���z1�I���2�s�lJX��J���T���M�[[u|�����F��]_6t8AbF�U/0/M-P��4�s@T2�aU��N��P)�Y*���,�
(�z�Gme����Ю0; T�����5"�,iR[���
��1�}b'nb&^b%Nb$>b#β\��2�uc2c1fs��{q���d����e/wy�s�m��e8�_���\�$�D*ެ�T|Y��x��R�c����*�GŇU<X�[U����P�*~C�k����������P�P�T�*^A�;U|�2�;���}�w���s�5��~G��Ɖ7�&�	h��hf�	f��+3ʄ2��"�l�M��c֘0&��bb��jV��0L��4��$�H:򍌓o�M��5�&�H4y&��!rLv�rK��#�iAN�QrI�r/��B�Vh"�
1�¨�)l
�£��h<ۙ�y��X��{��������to��^@O�������=���O�*�DJ��[��uðl��������)	Z"�f��\l�j��_5�eӜU,��#Պ���pv�@ ��p��z ��s�nN���Dr滛[�9�a��y<��7�x!_��A:���t�X���x�����a��\���V��;t<�����:���:~��3t<T�?u���W��N��=��ȣ�픞�-�ƌZ9�I�,<�qUA��C�LA��	�0'�du���8�y�8N��8�onsۚӨ���	3����8f��\+�Ct��:�.�uۼ:^ޡ���T@Jjm&P�K���>F||<��=�Cx������}o����-��=8o�9�{��9��}��wA�����}��|�����r�F�SSh�zgЖDT]����]�zo�����}�s�/���:����y�������Q��d$)()U�����s@B�c�2�b�!#2"��H0�6�`���;�2\*�p�m�vI����\s�ܑ�����L$��y�ҙ��p2!EZ��$����������-���\8Δ�v\��k�	�;f�@��
��2�W�έ�@��|x�м�����6�D�����ce�p-bPe��J���z���b�*�M��/�'q�+IX��G���4;���8>�z�-���= S�~�_��r~K��?8�s��gʿ�v}�+\w���ob��0�#�J�q�J
8M=���t��Ĵ�b�����-�A�\��R�?�]|�'�@�4��,�8? jRx=��op�v��̿�(�X���.��:w�.HSw3�Sֺ`����\�X
Q#�~�Y�"=5<�;
��N�BI��E"	�{��ʒ���7���dL(�/�`�	E/ JqD>P�I<x�	x�av��ͷΝǋ/�Ó���y� ��/_<2&'u�DmgX��ƿ��ho&�5Bd
-7+.���Y�^�9�,�3��v��U�8�i���g޺�eF�Ǭu��|�/��]�r�[�r���e_��VW��+Y��d�]l��g����WKm`⾧�:j��˃�8�޿��훼�|�w�����wk�t;�yϾY7�f��U�W�ٳ��<Vǖ-��+�a�a7,�fثŰ��VX
;a%l�����6X�`�k�o9��Lc�Җ�4�'-�G/��v�nA��|޳�v�3�����g7�y�i>s���/wy�Y�r���v�JN2��l�"y�jY�����U8Ȼ���۾�������R�p����z�4M�4M�4M�r���r����y;��(��v��f;
�dט8��N;�4�����〉��`0W{\�]kb�\b=,�9,�}k�V�����`�m��V�NK:ƍf4�լ���.6��[Lf2{-f1��`���^^1���b-k9�X�2�V�2�T~[�k�mu�f#�l�� �p���S]��ϩ'0�c���[�wM���f�m�v�kk��.۲M4�ű�۱=t����[���k�6n��Z3g�+�{`�\��L�����4����M���L��iL�}�K'�ҔF�'}��6�喱���u��c:��s�s�N���W_]�����p}��G8�u���;��u3��`�������,˲,˲,�)��A�U��I��Ȧ�� dс,���h�~�g+���Xt�c�����cy���c�u���m�f��(�^>c���kY,�]��Pk��p�f�^bAl��aw�;�B�r����v���U[����o��Z��n9��~����9��C��#��hrG;�4G4�����w�=�n��m��.�9�	=���=���y�=Ѐ6������}��p>�ٜn���y��s�=\n�{�^�w�q#�Zx=�@E?�?p?�9A|�p�����$�&��X���jciieB���R�����$I�$I�$�q�G��˱���n���n}�m�FM�t���m�<�g��,���n}��q�Zn�6�����q��r_[$�;y'�䝼�'u�cs,�lɖw~co,����X�9�����˵�ڭ��j���5�@h��7�5��+���UK�S�� ���f4��<щ�@ �@�����|>�����\,��b�X$�_�m��-�z�Ѯ����������6�^��PP������u���������X�u�������8���!�3�������9 �Z�1�J X}�h2 �Vnmk���ՙ�8� ��J�J<&��=�P���Uq+,�U�g�Mm�4ro<:�s���M���)�TA�"aO^-�yNӜ�w���Ov#�r�O��)��2)�!��XN7K7��Uba�<R���]5�j�գ�Ů�'WG�^��4�Hlk���>�jp R8�~U�$3�RSCC(�Z�Sw[remap]

importer="font_data_dynamic"
type="FontData"
uid="uid://dksjmw4cy83s4"
path="res://.godot/imported/montserrat.otf-0d875bde8933edfaf65407b0d9da84e5.fontdata"

[deps]

source_file="res://montserrat.otf"
dest_files=["res://.godot/imported/montserrat.otf-0d875bde8933edfaf65407b0d9da84e5.fontdata"]

[params]

antialiased=true
multichannel_signed_distance_field=false
msdf_pixel_range=8
msdf_size=48
force_autohinter=false
hinting=1
subpixel_positioning=1
embolden=0.0
transform=Transform2D(1, 0, 0, 1, 0, 0)
oversampling=0.0
compress=true
opentype_feature_overrides={}
preload/char_ranges=PackedStringArray()
preload/glyph_ranges=PackedStringArray()
preload/configurations=PackedStringArray()
support_overrides/language_enabled=PackedStringArray()
support_overrides/language_disabled=PackedStringArray()
support_overrides/script_enabled=PackedStringArray()
support_overrides/script_disabled=PackedStringArray()
j}�#���܌extends CharacterBody2D

const MOTION_SPEED = 90.0
const BOMB_RATE = 0.5

@export
var synced_position := Vector2()

@export
var stunned = false

@export
var ack = 0

@export
var sync_last_bomb_time = BOMB_RATE

@onready
var inputs = $Inputs
var last_bomb_time = BOMB_RATE
var current_anim = ""

var moveActions = []

func _ready():
	stunned = false
	position = synced_position
	if str(name).is_valid_int():
		get_node("Inputs/InputsSync").set_multiplayer_authority(str(name).to_int())


func _physics_process(delta):
	last_bomb_time += delta
	# sync_last_bomb_time = last_bomb_time
	
	if multiplayer.multiplayer_peer == null or str(multiplayer.get_unique_id()) == str(name):
		# The client which this player represent will update the controls state, and notify it to everyone.
		inputs.update()
		moveActions.append( inputs.register() )

	if multiplayer.multiplayer_peer == null or is_multiplayer_authority():
		# The server updates the position that will be notified to the clients.
		velocity = inputs.motion * MOTION_SPEED
		move_and_slide()
		
		# if ( ack != inputs.ack ):
		# var pos = position
		# var vel = inputs.motion * MOTION_SPEED * 0.01
		# pos += vel
		
		# position = pos
		synced_position = position
		
			# synced_position = position
		ack = inputs.ack
		
		# print( "server: " + str(inputs.ack) )
		
		# And increase the bomb cooldown spawning one if the client wants to.
		# last_bomb_time += delta
		# sync_last_bomb_time = last_bomb_time
		
		# print(sync_last_bomb_time)
		
		#if not stunned and is_multiplayer_authority() and inputs.bombing and last_bomb_time >= BOMB_RATE:
		#	last_bomb_time = 0.0
		#	get_node("../../BombSpawner").spawn([position, str(name).to_int(), ack])
	else:
		# print( "---------------------------------------------" )
		# print( moveActions.size() )
		# print( "server: " + str(ack) )
		
		# if moveActions.size() != 0:
		#	print( "client: " + str( moveActions[moveActions.size() - 1] ) )
		# print(position)
		
		# The client simply updates the position to the last known one.
		# position = synced_position
		
		# if not stunned:
		
		var index = 0;
		var notStop = true
		for action in moveActions:
			if notStop:
				index = index + 1
			if action['c'] == ack:
				notStop = false
		
		if notStop == false:
			moveActions = moveActions.slice(index, moveActions.size())
		
		# print(index)
		# print(moveActions)
		# print( "---------------------------------------------" )
		
		position = synced_position
		
		# if last_bomb_time == 0:2
		#	last_bomb_time = sync_last_bomb_time
		
		# if sync_last_bomb_time < BOMB_RATE:
		#	last_bomb_time = 0.0000001
		
		# if last_bomb_time != 0 and sync_last_bomb_time >= BOMB_RATE:
		# 	last_bomb_time = sync_last_bomb_time
		
		for action in moveActions:
			velocity = action.a * MOTION_SPEED
			move_and_slide()
		
	if inputs.bombing and last_bomb_time >= BOMB_RATE:
		if is_multiplayer_authority():
			get_node("../../BombSpawner").spawn([position, str(name).to_int(), ack])
			last_bomb_time = 0.0
		else:
			spawn_local([position, str(name).to_int(), ack])
			last_bomb_time = 0.0

	# if not stunned:
	#	# Everybody runs physics. I.e. clients tries to predict where they will be during the next frame.
	#	velocity = inputs.motion * MOTION_SPEED
	#	move_and_slide()

	# Also update the animation based on the last known player input state
	var new_anim = "standing"

	if inputs.motion.y < 0:
		new_anim = "walk_up"
	elif inputs.motion.y > 0:
		new_anim = "walk_down"
	elif inputs.motion.x < 0:
		new_anim = "walk_left"
	elif inputs.motion.x > 0:
		new_anim = "walk_right"

	if stunned:
		new_anim = "stunned"

	if new_anim != current_anim: 
		current_anim = new_anim
		get_node("anim").play(current_anim)


func set_player_name(value):
	get_node("label").text = value


@rpc(call_local)
func exploded(_by_who):
	if stunned:
		return
	stunned = true
	get_node("anim").play("stunned")


func spawn_local(data):
	if data.size() != 3 or typeof(data[0]) != TYPE_VECTOR2 or typeof(data[1]) != TYPE_INT:
		return null
	var bomb = preload("res://bomb.tscn").instantiate()
	bomb.position = data[0]
	bomb.from_player = data[1]
	bomb.ack = data[2]

	get_tree().root.add_child(bomb)

	return bomb
'�}�arq^[gd_scene load_steps=15 format=3 uid="uid://dviwgv2ty8v6u"]

[ext_resource type="Script" path="res://player.gd" id="1"]
[ext_resource type="Texture2D" uid="uid://bsqovikudjr0q" path="res://charwalk.png" id="2"]
[ext_resource type="FontData" uid="uid://dksjmw4cy83s4" path="res://montserrat.otf" id="3"]
[ext_resource type="Script" path="res://player_controls.gd" id="4_k1vfr"]

[sub_resource type="CircleShape2D" id="1"]
radius = 20.0

[sub_resource type="Animation" id="2"]
resource_name = "standing"
length = 0.8
loop_mode = 1
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("sprite:frame")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0, 0.2, 0.4, 0.6),
"transitions": PackedFloat32Array(1, 1, 1, 1),
"update": 1,
"values": [0, 4, 8, 12]
}

[sub_resource type="Animation" id="3"]
resource_name = "stunned"
length = 1.2
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("sprite:frame")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0),
"transitions": PackedFloat32Array(1),
"update": 1,
"values": [0]
}
tracks/1/type = "value"
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/path = NodePath(".:stunned")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/keys = {
"times": PackedFloat32Array(1),
"transitions": PackedFloat32Array(1),
"update": 1,
"values": [false]
}
tracks/2/type = "value"
tracks/2/imported = false
tracks/2/enabled = true
tracks/2/path = NodePath("sprite:rotation")
tracks/2/interp = 1
tracks/2/loop_wrap = true
tracks/2/keys = {
"times": PackedFloat32Array(0, 1),
"transitions": PackedFloat32Array(1, 1),
"update": 0,
"values": [-6.28319, 0.0]
}

[sub_resource type="Animation" id="4"]
length = 0.8
loop_mode = 1
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("sprite:frame")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0, 0.2, 0.4, 0.6),
"transitions": PackedFloat32Array(1, 1, 1, 1),
"update": 1,
"values": [0, 4, 8, 12]
}

[sub_resource type="Animation" id="5"]
length = 0.8
loop_mode = 1
step = 0.2
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("sprite:frame")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0, 0.2, 0.4, 0.6),
"transitions": PackedFloat32Array(1, 1, 1, 1),
"update": 1,
"values": [1, 5, 9, 13]
}

[sub_resource type="Animation" id="6"]
length = 0.8
loop_mode = 1
step = 0.2
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("sprite:frame")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0, 0.2, 0.4, 0.6),
"transitions": PackedFloat32Array(1, 1, 1, 1),
"update": 1,
"values": [3, 7, 11, 15]
}

[sub_resource type="Animation" id="7"]
length = 0.8
loop_mode = 1
step = 0.2
tracks/0/type = "value"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath("sprite:frame")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(0, 0.2, 0.4, 0.6),
"transitions": PackedFloat32Array(1, 1, 1, 1),
"update": 1,
"values": [2, 6, 10, 14]
}

[sub_resource type="Font" id="8"]
data/0 = ExtResource( "3" )

[sub_resource type="SceneReplicationConfig" id="SceneReplicationConfig_xm6wv"]
properties/0/path = NodePath(".:synced_position")
properties/0/spawn = true
properties/0/sync = true
properties/1/path = NodePath("label:text")
properties/1/spawn = true
properties/1/sync = false
properties/2/path = NodePath(":ack")
properties/2/spawn = true
properties/2/sync = true
properties/3/path = NodePath(":sync_last_bomb_time")
properties/3/spawn = true
properties/3/sync = true

[sub_resource type="SceneReplicationConfig" id="SceneReplicationConfig_kkxsa"]
properties/0/path = NodePath(".:motion")
properties/0/spawn = true
properties/0/sync = true
properties/1/path = NodePath(".:bombing")
properties/1/spawn = true
properties/1/sync = true
properties/2/path = NodePath(":ack")
properties/2/spawn = true
properties/2/sync = true

[node name="player" type="CharacterBody2D"]
motion_mode = 1
script = ExtResource( "1" )

[node name="sprite" type="Sprite2D" parent="."]
position = Vector2(0.0750351, 6.23615)
rotation = -6.28319
texture = ExtResource( "2" )
offset = Vector2(-0.0750351, -6.23615)
hframes = 4
vframes = 4

[node name="shape" type="CollisionShape2D" parent="."]
shape = SubResource( "1" )

[node name="anim" type="AnimationPlayer" parent="."]
anims/standing = SubResource( "2" )
anims/stunned = SubResource( "3" )
anims/walk_down = SubResource( "4" )
anims/walk_left = SubResource( "5" )
anims/walk_right = SubResource( "6" )
anims/walk_up = SubResource( "7" )

[node name="label" type="Label" parent="."]
offset_left = -82.0
offset_top = -35.0
offset_right = 85.0
offset_bottom = -14.0
size_flags_horizontal = 2
size_flags_vertical = 0
theme_override_fonts/font = SubResource( "8" )
theme_override_font_sizes/font_size = 16
text = "Player 1"
horizontal_alignment = 1

[node name="MultiplayerSynchronizer" type="MultiplayerSynchronizer" parent="."]
root_path = NodePath("..")
resource = SubResource( "SceneReplicationConfig_xm6wv" )

[node name="Inputs" type="Node" parent="."]
script = ExtResource( "4_k1vfr" )

[node name="InputsSync" type="MultiplayerSynchronizer" parent="Inputs"]
root_path = NodePath("..")
resource = SubResource( "SceneReplicationConfig_kkxsa" )
kO�extends Node

@export
var motion = Vector2() :
	set(value):
		# This will be sent by players, make sure values are within limits.
		motion = clamp(value, Vector2(-1, -1), Vector2(1, 1))

@export
var bombing = false

@export
var ack = 0

var player;

func _ready(): 
	player = get_node('..')

func update():
	var m = Vector2()
	if Input.is_action_pressed("move_left"):
		m += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		m += Vector2(1, 0)
	if Input.is_action_pressed("move_up"):
		m += Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		m += Vector2(0, 1)

	motion = m
	bombing = Input.is_action_pressed("set_bomb")
	# ack = ack + 1
	ack = Time.get_ticks_msec() % 1000
	
	# if not is_multiplayer_authority():
	# 	print(Time.get_ticks_msec())
	
	# if bombing and player.last_bomb_time >= player.BOMB_RATE:
		# get_node("../../../BombSpawner").spawn([player.position, str(player.name).to_int()])
	#	spawn_local([player.position, str(player.name).to_int(), ack])
	#	player.last_bomb_time = 0.0

func register():
	return { 'a': motion, 'b': bombing, 'c': ack }

func spawn_local(data):
	if data.size() != 3 or typeof(data[0]) != TYPE_VECTOR2 or typeof(data[1]) != TYPE_INT:
		return null
	var bomb = preload("res://bomb.tscn").instantiate()
	bomb.position = data[0]
	bomb.from_player = data[1]
	bomb.ack = data[2]

	add_child(bomb)

	return bomb
�ᠷo�B��eRextends CharacterBody2D

@rpc(call_local)
func exploded(by_who):
	$"../../Score".increase_score(by_who)
	$"AnimationPlayer".play("explode")
�e[gd_scene load_steps=5 format=3 uid="uid://bao3yernlglws"]

[ext_resource type="Script" path="res://rock.gd" id="1"]
[ext_resource type="Texture2D" uid="uid://bdomqql6y50po" path="res://brickfloor.png" id="2"]

[sub_resource type="RectangleShape2D" id="1"]
size = Vector2(48, 48)

[sub_resource type="Animation" id="2"]
resource_name = "explode"
tracks/0/type = "method"
tracks/0/imported = false
tracks/0/enabled = true
tracks/0/path = NodePath(".")
tracks/0/interp = 1
tracks/0/loop_wrap = true
tracks/0/keys = {
"times": PackedFloat32Array(1),
"transitions": PackedFloat32Array(1),
"values": [{
"args": [],
"method": &"queue_free"
}]
}
tracks/1/type = "value"
tracks/1/imported = false
tracks/1/enabled = true
tracks/1/path = NodePath("Sprite:visible")
tracks/1/interp = 1
tracks/1/loop_wrap = true
tracks/1/keys = {
"times": PackedFloat32Array(0),
"transitions": PackedFloat32Array(1),
"update": 1,
"values": [false]
}

[node name="Rock" type="CharacterBody2D"]
motion_mode = 1
script = ExtResource( "1" )

[node name="Sprite" type="Sprite2D" parent="."]
texture = ExtResource( "2" )
region_enabled = true
region_rect = Rect2(96, 0, 48, 48)

[node name="Shape" type="CollisionShape2D" parent="."]
shape = SubResource( "1" )

[node name="AnimationPlayer" type="AnimationPlayer" parent="."]
anims/explode = SubResource( "2" )
GST2            ����                        X   WEBPRIFFL   WEBPVP8L@   / ��m���~�sR�6t�z��y(d:�_�<�? ��?���m���K��m�"����k[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bh4gbjcayios1"
path="res://.godot/imported/rock_bit.png-cd30ec3dce7edf848ee632b29d4d0c95.ctex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://rock_bit.png"
dest_files=["res://.godot/imported/rock_bit.png-cd30ec3dce7edf848ee632b29d4d0c95.ctex"]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/bptc_ldr=0
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/size_limit=0
detect_3d/compress_to=1
kextends HBoxContainer

var player_labels = {}

func _process(_delta):
	var rocks_left = $"../Rocks".get_child_count()
	if rocks_left == 0:
		var winner_name = ""
		var winner_score = 0
		for p in player_labels:
			if player_labels[p].score > winner_score:
				winner_score = player_labels[p].score
				winner_name = player_labels[p].name

		$"../Winner".set_text("THE WINNER IS:\n" + winner_name)
		$"../Winner".show()


func increase_score(for_who):
	assert(for_who in player_labels)
	var pl = player_labels[for_who]
	pl.score += 1
	pl.label.set_text(pl.name + "\n" + str(pl.score))


func add_player(id, new_player_name):
	var l = Label.new()
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.set_text(new_player_name + "\n" + "0")
	l.set_h_size_flags(SIZE_EXPAND_FILL)
	var font = Font.new()
	font.add_data(preload("res://montserrat.otf"))
	l.set("custom_fonts/font", font)
	l.set("custom_font_size/font_size", 18)
	add_child(l)

	player_labels[id] = { name = new_player_name, label = l, score = 0 }


func _ready():
	$"../Winner".hide()
	set_process(true)


func _on_exit_game_pressed():
	gamestate.end_game()
�1?�=���Jlmç�[gd_scene load_steps=3 format=3 uid="uid://c5m3rogpaglk1"]

[ext_resource type="Texture2D" uid="uid://bdomqql6y50po" path="res://brickfloor.png" id="1"]

[sub_resource type="RectangleShape2D" id="1"]
size = Vector2(48, 48)

[node name="TileScene" type="Node2D"]

[node name="Wall" type="Sprite2D" parent="."]
position = Vector2(24, 24)
texture = ExtResource( "1" )
region_rect = Rect2(0, 0, 48, 48)

[node name="StaticBody2D" type="StaticBody2D" parent="Wall"]

[node name="CollisionShape2D" type="CollisionShape2D" parent="Wall/StaticBody2D"]
shape = SubResource( "1" )

[node name="Floor" type="Sprite2D" parent="."]
position = Vector2(72, 24)
texture = ExtResource( "1" )
region_rect = Rect2(48, 0, 48, 48)
958�rd[gd_resource type="TileSet" load_steps=3 format=3 uid="uid://do2l6lpuotti8"]

[ext_resource type="Texture2D" uid="uid://bdomqql6y50po" path="res://brickfloor.png" id="1"]

[sub_resource type="TileSetAtlasSource" id="TileSetAtlasSource_qhkfp"]
texture = ExtResource( "1" )
texture_region_size = Vector2i(48, 48)
0:0/0 = 0
0:0/0/physics_layer_0/linear_velocity = Vector2(0, 0)
0:0/0/physics_layer_0/angular_velocity = 0.0
0:0/0/physics_layer_0/polygon_0/points = PackedVector2Array(-24, -24, 24, -24, 24, 24, -24, 24)
1:0/0 = 0
1:0/0/physics_layer_0/linear_velocity = Vector2(0, 0)
1:0/0/physics_layer_0/angular_velocity = 0.0

[resource]
tile_size = Vector2i(48, 48)
physics_layer_0/collision_layer = 1
sources/0 = SubResource( "TileSetAtlasSource_qhkfp" )
Վʶ�y�*V��[gd_scene load_steps=8 format=3 uid="uid://by3f5o7dyoqx4"]

[ext_resource type="TileSet" uid="uid://do2l6lpuotti8" path="res://tileset.tres" id="1"]
[ext_resource type="PackedScene" uid="uid://bao3yernlglws" path="res://rock.tscn" id="2"]
[ext_resource type="Script" path="res://score.gd" id="3"]
[ext_resource type="FontData" uid="uid://dksjmw4cy83s4" path="res://montserrat.otf" id="4"]
[ext_resource type="PackedScene" uid="uid://dviwgv2ty8v6u" path="res://player.tscn" id="5_yef4r"]
[ext_resource type="Script" path="res://bomb_spawner.gd" id="6_ac5ja"]

[sub_resource type="Font" id="1"]
data/0 = ExtResource( "4" )

[node name="World" type="Node2D"]

[node name="TileMap" type="TileMap" parent="."]
tile_set = ExtResource( "1" )
cell_quadrant_size = 48
format = 2
layer_0/tile_data = PackedInt32Array(196598, 0, 0, 0, 0, 0, 65536, 0, 0, 131072, 0, 0, 196608, 0, 0, 262144, 0, 0, 327680, 0, 0, 393216, 0, 0, 458752, 0, 0, 524288, 0, 0, 589824, 0, 0, 655360, 0, 0, 720896, 0, 0, 786432, 0, 0, 1, 0, 0, 65537, 65536, 0, 131073, 65536, 0, 196609, 65536, 0, 262145, 65536, 0, 327681, 65536, 0, 393217, 65536, 0, 458753, 65536, 0, 524289, 65536, 0, 589825, 65536, 0, 655361, 65536, 0, 720897, 65536, 0, 786433, 0, 0, 2, 0, 0, 65538, 65536, 0, 131074, 0, 0, 196610, 65536, 0, 262146, 0, 0, 327682, 65536, 0, 393218, 0, 0, 458754, 65536, 0, 524290, 0, 0, 589826, 65536, 0, 655362, 0, 0, 720898, 65536, 0, 786434, 0, 0, 3, 0, 0, 65539, 65536, 0, 131075, 65536, 0, 196611, 65536, 0, 262147, 65536, 0, 327683, 65536, 0, 393219, 65536, 0, 458755, 65536, 0, 524291, 0, 0, 589827, 65536, 0, 655363, 65536, 0, 720899, 65536, 0, 786435, 0, 0, 4, 0, 0, 65540, 65536, 0, 131076, 0, 0, 196612, 0, 0, 262148, 0, 0, 327684, 65536, 0, 393220, 0, 0, 458756, 65536, 0, 524292, 0, 0, 589828, 65536, 0, 655364, 0, 0, 720900, 65536, 0, 786436, 0, 0, 5, 0, 0, 65541, 65536, 0, 131077, 65536, 0, 196613, 65536, 0, 262149, 65536, 0, 327685, 65536, 0, 393221, 65536, 0, 458757, 65536, 0, 524293, 65536, 0, 589829, 65536, 0, 655365, 65536, 0, 720901, 65536, 0, 786437, 0, 0, 6, 0, 0, 65542, 65536, 0, 131078, 0, 0, 196614, 65536, 0, 262150, 0, 0, 327686, 0, 0, 393222, 0, 0, 458758, 65536, 0, 524294, 0, 0, 589830, 65536, 0, 655366, 0, 0, 720902, 65536, 0, 786438, 0, 0, 7, 0, 0, 65543, 65536, 0, 131079, 65536, 0, 196615, 65536, 0, 262151, 65536, 0, 327687, 65536, 0, 393223, 65536, 0, 458759, 65536, 0, 524295, 65536, 0, 589831, 65536, 0, 655367, 65536, 0, 720903, 65536, 0, 786439, 0, 0, 8, 0, 0, 65544, 65536, 0, 131080, 0, 0, 196616, 65536, 0, 262152, 0, 0, 327688, 65536, 0, 393224, 0, 0, 458760, 65536, 0, 524296, 0, 0, 589832, 65536, 0, 655368, 0, 0, 720904, 65536, 0, 786440, 0, 0, 9, 0, 0, 65545, 65536, 0, 131081, 65536, 0, 196617, 65536, 0, 262153, 65536, 0, 327689, 65536, 0, 393225, 65536, 0, 458761, 65536, 0, 524297, 65536, 0, 589833, 65536, 0, 655369, 65536, 0, 720905, 65536, 0, 786441, 0, 0, 10, 0, 0, 65546, 65536, 0, 131082, 0, 0, 196618, 0, 0, 262154, 0, 0, 327690, 65536, 0, 393226, 0, 0, 458762, 65536, 0, 524298, 0, 0, 589834, 65536, 0, 655370, 0, 0, 720906, 65536, 0, 786442, 0, 0, 11, 0, 0, 65547, 65536, 0, 131083, 0, 0, 196619, 65536, 0, 262155, 65536, 0, 327691, 65536, 0, 393227, 65536, 0, 458763, 65536, 0, 524299, 65536, 0, 589835, 65536, 0, 655371, 65536, 0, 720907, 65536, 0, 786443, 0, 0, 12, 0, 0, 65548, 65536, 0, 131084, 0, 0, 196620, 65536, 0, 262156, 0, 0, 327692, 65536, 0, 393228, 0, 0, 458764, 65536, 0, 524300, 0, 0, 589836, 65536, 0, 655372, 0, 0, 720908, 65536, 0, 786444, 0, 0, 13, 0, 0, 65549, 65536, 0, 131085, 0, 0, 196621, 65536, 0, 262157, 65536, 0, 327693, 65536, 0, 393229, 0, 0, 458765, 65536, 0, 524301, 0, 0, 589837, 65536, 0, 655373, 65536, 0, 720909, 65536, 0, 786445, 0, 0, 14, 0, 0, 65550, 65536, 0, 131086, 0, 0, 196622, 65536, 0, 262158, 0, 0, 327694, 65536, 0, 393230, 0, 0, 458766, 65536, 0, 524302, 0, 0, 589838, 65536, 0, 655374, 0, 0, 720910, 65536, 0, 786446, 0, 0, 15, 0, 0, 65551, 65536, 0, 131087, 65536, 0, 196623, 65536, 0, 262159, 65536, 0, 327695, 65536, 0, 393231, 0, 0, 458767, 65536, 0, 524303, 65536, 0, 589839, 65536, 0, 655375, 65536, 0, 720911, 65536, 0, 786447, 0, 0, 16, 0, 0, 65552, 65536, 0, 131088, 0, 0, 196624, 65536, 0, 262160, 0, 0, 327696, 65536, 0, 393232, 0, 0, 458768, 65536, 0, 524304, 0, 0, 589840, 65536, 0, 655376, 0, 0, 720912, 65536, 0, 786448, 0, 0, 17, 0, 0, 65553, 65536, 0, 131089, 65536, 0, 196625, 65536, 0, 262161, 65536, 0, 327697, 65536, 0, 393233, 65536, 0, 458769, 65536, 0, 524305, 65536, 0, 589841, 65536, 0, 655377, 65536, 0, 720913, 65536, 0, 786449, 0, 0, 18, 0, 0, 65554, 65536, 0, 131090, 0, 0, 196626, 65536, 0, 262162, 0, 0, 327698, 0, 0, 393234, 0, 0, 458770, 65536, 0, 524306, 0, 0, 589842, 65536, 0, 655378, 0, 0, 720914, 65536, 0, 786450, 0, 0, 19, 0, 0, 65555, 65536, 0, 131091, 65536, 0, 196627, 65536, 0, 262163, 65536, 0, 327699, 65536, 0, 393235, 65536, 0, 458771, 65536, 0, 524307, 65536, 0, 589843, 65536, 0, 655379, 65536, 0, 720915, 65536, 0, 786451, 0, 0, 20, 0, 0, 65556, 0, 0, 131092, 0, 0, 196628, 0, 0, 262164, 0, 0, 327700, 0, 0, 393236, 0, 0, 458772, 0, 0, 524308, 0, 0, 589844, 0, 0, 655380, 0, 0, 720916, 0, 0, 786452, 0, 0, 21, 0, 0, 65557, 0, 0, 131093, 0, 0, 196629, 0, 0, 262165, 0, 0, 327701, 0, 0, 393237, 0, 0, 458773, 0, 0, 524309, 0, 0, 589845, 0, 0, 655381, 0, 0, 720917, 0, 0, 786453, 0, 0)

[node name="SpawnPoints" type="Node2D" parent="."]

[node name="0" type="Position2D" parent="SpawnPoints"]
position = Vector2(72, 72)

[node name="1" type="Position2D" parent="SpawnPoints"]
position = Vector2(264, 216)

[node name="2" type="Position2D" parent="SpawnPoints"]
position = Vector2(72, 456)

[node name="3" type="Position2D" parent="SpawnPoints"]
position = Vector2(360, 552)

[node name="4" type="Position2D" parent="SpawnPoints"]
position = Vector2(840, 360)

[node name="5" type="Position2D" parent="SpawnPoints"]
position = Vector2(456, 264)

[node name="6" type="Position2D" parent="SpawnPoints"]
position = Vector2(696, 264)

[node name="7" type="Position2D" parent="SpawnPoints"]
position = Vector2(744, 456)

[node name="8" type="Position2D" parent="SpawnPoints"]
position = Vector2(312, 456)

[node name="9" type="Position2D" parent="SpawnPoints"]
position = Vector2(696, 72)

[node name="10" type="Position2D" parent="SpawnPoints"]
position = Vector2(504, 72)

[node name="11" type="Position2D" parent="SpawnPoints"]
position = Vector2(936, 72)

[node name="Rocks" type="Node2D" parent="."]

[node name="Rock0" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(120, 72)

[node name="Rock1" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(264, 168)

[node name="Rock2" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(264, 120)

[node name="Rock3" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(216, 72)

[node name="Rock4" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(264, 72)

[node name="Rock5" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(312, 72)

[node name="Rock6" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(552, 168)

[node name="Rock7" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(600, 168)

[node name="Rock8" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(552, 216)

[node name="Rock9" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(264, 312)

[node name="Rock10" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(120, 360)

[node name="Rock11" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(168, 360)

[node name="Rock12" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(216, 360)

[node name="Rock13" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(120, 264)

[node name="Rock14" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(168, 216)

[node name="Rock15" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(72, 360)

[node name="Rock16" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(72, 312)

[node name="Rock17" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(72, 264)

[node name="Rock18" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(360, 360)

[node name="Rock19" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(408, 360)

[node name="Rock20" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(504, 360)

[node name="Rock21" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(600, 360)

[node name="Rock22" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(648, 360)

[node name="Rock23" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(504, 456)

[node name="Rock24" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(552, 456)

[node name="Rock25" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(552, 408)

[node name="Rock26" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(360, 456)

[node name="Rock27" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(360, 504)

[node name="Rock28" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(264, 504)

[node name="Rock29" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(264, 552)

[node name="Rock30" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(168, 456)

[node name="Rock31" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(168, 504)

[node name="Rock32" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(72, 552)

[node name="Rock33" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(120, 552)

[node name="Rock34" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(504, 552)

[node name="Rock35" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(600, 552)

[node name="Rock36" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(648, 552)

[node name="Rock37" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(648, 504)

[node name="Rock38" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(456, 216)

[node name="Rock39" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(360, 216)

[node name="Rock40" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(360, 168)

[node name="Rock41" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(456, 120)

[node name="Rock42" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(456, 408)

[node name="Rock43" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(456, 456)

[node name="Rock44" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(456, 504)

[node name="Rock45" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(600, 264)

[node name="Rock46" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(600, 72)

[node name="Rock47" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(408, 72)

[node name="Rock48" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(792, 168)

[node name="Rock49" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(744, 168)

[node name="Rock50" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(744, 264)

[node name="Rock51" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(792, 264)

[node name="Rock52" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(744, 360)

[node name="Rock53" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(744, 408)

[node name="Rock54" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(792, 552)

[node name="Rock55" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 552)

[node name="Rock56" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 504)

[node name="Rock57" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 312)

[node name="Rock58" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 264)

[node name="Rock59" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 216)

[node name="Rock60" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 120)

[node name="Rock61" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(792, 72)

[node name="Rock62" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 72)

[node name="Rock63" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(936, 216)

[node name="Rock64" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(936, 264)

[node name="Rock65" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(936, 408)

[node name="Rock66" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(888, 456)

[node name="Rock67" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(936, 456)

[node name="Rock68" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(792, 456)

[node name="Rock69" parent="Rocks" instance=ExtResource( "2" )]
position = Vector2(840, 456)

[node name="Players" type="Node2D" parent="."]

[node name="Score" type="HBoxContainer" parent="."]
offset_right = 1024.0
offset_bottom = 40.0
size_flags_horizontal = 2
size_flags_vertical = 2
script = ExtResource( "3" )

[node name="Winner" type="Label" parent="."]
visible = false
offset_right = 1031.0
offset_bottom = 617.0
size_flags_horizontal = 2
size_flags_vertical = 0
theme_override_constants/shadow_offset_x = 2
theme_override_constants/shadow_offset_y = 2
theme_override_fonts/font = SubResource( "1" )
text = "THE WINNER IS:
YOU"

[node name="ExitGame" type="Button" parent="Winner"]
offset_left = 384.0
offset_top = 408.0
offset_right = 649.0
offset_bottom = 469.0
size_flags_horizontal = 2
size_flags_vertical = 2
theme_override_fonts/font = SubResource( "1" )
text = "EXIT GAME"

[node name="Camera2D" type="Camera2D" parent="."]
offset = Vector2(512, 300)
current = true

[node name="PlayerSpawner" type="MultiplayerSpawner" parent="."]
replication = [ExtResource( "5_yef4r" )]
spawn_path = NodePath("../Players")
auto_spawn = true

[node name="BombSpawner" type="MultiplayerSpawner" parent="."]
spawn_path = NodePath("..")
script = ExtResource( "6_ac5ja" )

[connection signal="pressed" from="Winner/ExitGame" to="Score" method="_on_exit_game_pressed"]
�o��&�4�PNG

   IHDR   @   @   ����   �PLTE�������ͫ�[ܤz��5l���kK�p#�e$Rg�FS}pK{@%1Aj1:=48,%$$#""!! ! g���  �IDATxڭԅ�� ��H��af�����;ݙĎeoU*��e)���	��B�(	��z�6�]���#F'.���)�9p�`_a s��r޺�K��F���6e �5&��n�A$ λm<l����u�&���u�{+�ˢ�������t� � Ή�n��Xf �(��3/>��\�+mྏҙ
�ߍ�� �q�#�ʊ�k�:�� ��� �������:��Dou����w��k���g�gn?��^�v�&�ҿ%�y%�E��&p[���@�;�CeTg |�jv{Ǚ}��<M�ġw���r�Ѽ�"W`_%Ye �+�գ2�H�r.��>�]����k����^r X)�Ac��
*���L��]�����#_[k�)8 k�6�M)��n%d �|�چNFAr쫅I���9H�؁���%�"p����dҨu�
�_Ă�;�����|��M�_sL�r�$
�gN�&�-M&���c�}G���=M�`L�die49oZ��ւNm�g Yl|R�0�Z$��^p�Tg �)��zIm2�A����	*w}E�H�Ybao��$ ���݈}�-��V��J��J�04&DkQ4�w�䚵����:�@��0(p�{p�w��H�=Ԓ��9��
A2�N�E��I�x�W�X�EߍVV-���j���MK���Fi�xd��t����`�pQ�� ��١�?~���a��_    IEND�B`��R�1lLH�Fj��   �����bj%   res://html/index.apple-touch-icon.png�#�`��;   res://html/index.icon.png����$��'   res://html/index.png���1�I   res://bomb.tscn ';�s$   res://brickfloor.png4�D3   res://charwalk.png��|���t   res://explosion.png�?Tv%�BC   res://icon.png��݉N�   res://lobby.tscny��t�m   res://montserrat.otf�j���x   res://player.tscnj4�>�#�!   res://rock.tscnv��,���(   res://rock_bit.png�94W-t�q   res://tileset.tres�ՀW]��_   res://tile_scene.tscn���ΎM9   res://world.tscnq.U���ECFG      application/config/name         Multiplayer Bomber     application/config/description�      �   A multiplayer implementation of the classical bomberman game.
One of the players should press 'host', while the other
should type in his address and press 'play'.     application/run/main_scene         res://lobby.tscn   application/config/icon         res://icon.png     application/config/features            4.0    autoload/gamestate         *res://gamestate.gd .   debug/gdscript/warnings/return_value_discarded             display/window/stretch/mode         2d     display/window/stretch/aspect         expand     display/window/vsync/use_vsync             editor_plugins/enabled             gdnative/singletons             image_loader/filter             image_loader/gen_mipmaps             input/move_down@              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode    S      physical_keycode          unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode         physical_keycode          unicode           echo          script         input/move_left@              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode    A      physical_keycode          unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode         physical_keycode          unicode           echo          script         input/move_right@              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode    D      physical_keycode          unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode         physical_keycode          unicode           echo          script         input/move_up@              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode    W      physical_keycode          unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode         physical_keycode          unicode           echo          script         input/set_bomb�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             store_command            alt_pressed           shift_pressed             meta_pressed          command_pressed           pressed           keycode           physical_keycode          unicode           echo          script      $   rendering/quality/driver/driver_name         GLES2      replication/config,              uid://dviwgv2ty8v6u          
   replicated              spawn_properties             sync_interval               sync_properties             :stunned      sprite:hframes        sprite:vframes        :server_position   
   label:text        synced         �y;���w��W