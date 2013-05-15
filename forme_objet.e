note
	description: "balle du jeu, toujours utilisé dans déplacement et dans game"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	FORME_OBJET
inherit
	GAME
create
	creer_forme
feature
	Y:INTEGER_16
	X:INTEGER_16
	target_area, l_bmp:POINTER
	nom:STRING

	creer_forme(l_X:INTEGER_16 l_Y:INTEGER_16 l_nom:STRING)
	-- création de la forme selon les paramètres
		local
			l_memory_manager:POINTER
			l_image_nom:STRING
			l_c_string_bmp:C_STRING
			l_blit_surface:INTEGER
		do
			create l_memory_manager.default_create
			create l_c_string_bmp.make (l_nom)
			target_area := l_memory_manager.memory_alloc({SDL_WRAPPER}.sizeof_SDL_Rect)
			l_bmp := {SDL_WRAPPER}.SDL_LoadBMP(l_c_string_bmp.item)
			Y:=l_Y
			X:=l_X
			nom:=l_nom
		end
		---------------------------------------------player
	set_player1_Y(l_player1_Y:INTEGER_16)
	-- change le Y
		do
			Y := Y+l_player1_Y
		end
	set_X(l_player1_X:INTEGER_16)
	-- change le X
		do
			X := X+l_player1_X
		end
invariant
	dans_screen_y: Y<=720 and Y>=0
	pointeurs_non_null: target_area /= void and l_bmp /= void
	image_definie: nom /= ""

note
	copyright: "Copyright (c) 2012-2013, Étienne Boisjoli et Anthony Martel"
	license: "AGPL 3.0 (see http://www.gnu.org/licenses/agpl.txt)"
	source: "[
		Étienne Boisjoli et Anthony Martel
		Étudiants
		Cégep de Drummondville
		960, rue Saint-Georges
		Drummondville, (Québec)
		J2C-6A2
		Telephone 819 478-4671, Fax 819 474-6859
		Site Web http://www.cdrummond.qc.ca
	]"
end
