note
	description: "gère le pointage et les interractions avec la base de données"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	POINTAGE

inherit
	GAME
	IMAGE
create
	creer_pointage,
	ttf_init,
	ttf_openFont
feature
	l_insert: SQLITE_INSERT_STATEMENT
	l_query: SQLITE_QUERY_STATEMENT
	l_modify: SQLITE_MODIFY_STATEMENT
	l_set: SQLITE_RESULT_SET
	l_db: SQLITE_DATABASE
	l_font:POINTER
	l_point1:INTEGER_64
	l_point2:INTEGER_64


ttf_init
--Initialisation du TTF et validation d'erreur.
	do
		if
			{SDL_WRAPPER}.TTF_INIT < 0
		then
			print ("Initialisation Text a échoué!%N")
		end
	end


ttf_openFont
--Creation et Ouverture de la font
	local
		l_c_string_font:C_STRING
	do
		create l_c_string_font.make ("Ressources/game_over.ttf")
		l_font := {SDL_WRAPPER}.TTF_OpenFont(l_c_string_font.item, 200)
	end

ttf_pointage(l_window:POINTER)
-- affichage du pointage
	local
		color:POINTER
		text:C_STRING
		textImage:POINTER
		test:POINTER
		l_target_area:POINTER
		l_memory_manager:POINTER
		l_pointage_joueur1:STRING
--		l_point1:INTEGER_64
--		l_point2:INTEGER_64
	do
		l_point1 := 0
		l_point2 := 0
		create l_query.make ("SELECT * FROM pointage WHERE joueur = '1';", l_db)
		l_query.execute (agent (ia_row: SQLITE_RESULT_ROW): BOOLEAN
			do
				l_point1 := ia_row.integer_64_value (2)
			end)

		create l_query.make ("SELECT * FROM pointage WHERE joueur = '2';", l_db)
		l_query.execute (agent (ia_row: SQLITE_RESULT_ROW): BOOLEAN
			do
				l_point2 := ia_row.integer_64_value (2)
			end)

		create text.make (l_point1.out+"           "+l_point2.out)

		color := l_memory_manager.memory_alloc({SDL_WRAPPER}.sizeof_SDL_Color)
		{SDL_WRAPPER}.set_SDL_color_r(color,255)
		{SDL_WRAPPER}.set_SDL_color_g(color,255)
		{SDL_WRAPPER}.set_SDL_color_b(color,255)
		textImage:={SDL_WRAPPER}.TTF_RenderText_Solid(l_font, text.item, color)
	--
l_target_area := l_memory_manager.memory_alloc({SDL_WRAPPER}.sizeof_SDL_Rect)
		{SDL_WRAPPER}.set_SDL_target_area_H(l_target_area, 0)
		{SDL_WRAPPER}.set_SDL_target_area_W(l_target_area, 0)
		{SDL_WRAPPER}.set_SDL_target_area_X(l_target_area, 500)
		{SDL_WRAPPER}.set_SDL_target_area_Y(l_target_area, 20)


		if {SDL_WRAPPER}.SDL_BlitSurface(textImage, create {POINTER}, l_window, l_target_area)<1  then
		end
	end

	creer_pointage
	-- création de la base de données
			-- Run application.
		do
			l_point1:=0
			l_point2:=0
			create l_db.make_create_read_write ("BD/pointage.sqlite")

        	-- Remove any existing table
			create l_modify.make ("DROP TABLE IF EXISTS pointage;", l_db)
			l_modify.execute

			-- Create a new table
			create l_modify.make ("CREATE TABLE `pointage` (`Joueur` INTEGER PRIMARY KEY, `Points` INTEGER);", l_db)
			l_modify.execute

			create l_insert.make ("INSERT INTO `pointage` (`Points`) VALUES (:POINT1);", l_db)
			check l_insert_is_compiled: l_insert.is_compiled end
			l_insert.execute_with_arguments ([create {SQLITE_DOUBLE_ARG}.make (":POINT1", l_point1)])


			create l_insert.make ("INSERT INTO `pointage` (`Points`) VALUES (:POINT2);", l_db)
			check l_insert_is_compiled: l_insert.is_compiled end
			l_insert.execute_with_arguments ([create {SQLITE_DOUBLE_ARG}.make (":POINT2", l_point2)])

			l_db.begin_transaction (False)
			l_db.commit

			--afficher_bd()
end

--afficher_bd
--	do
--			create l_query.make ("SELECT * FROM pointage;", l_db)
--			l_query.execute (agent (ia_row: SQLITE_RESULT_ROW): BOOLEAN
--				local
--					j, j_count: NATURAL
--				do
--					from
--						j := 1
--						j_count := ia_row.count
--					until
--						j > j_count
--					loop
--						if not ia_row.is_null (j) then
--							if j = 1 then
--								print ("Joueur " + ia_row.string_value (j) + ": ")
--							end
--							if j = 2 then
--								print (ia_row.string_value (j) + " Points")
--							end
--						else
--							print ("<NULL>")
--					end
--						j := j + 1
--					end
--					print ("%N")
--				end)
--	end

point_joueur1
-- point suplémentaire pour le joueur 1
		local
			l_update: SQLITE_MODIFY_STATEMENT
		do
			l_point1:= l_point1+1
			create l_update.make ("UPDATE `pointage` SET `Points`=:POINT1 WHERE `Joueur` = 1;", l_db)
			check l_update_is_compiled: l_update.is_compiled end

			l_db.begin_transaction (False)
			l_update.execute_with_arguments ([create {SQLITE_INTEGER_ARG}.make (":POINT1", l_point1)])

			l_db.commit

		end

point_joueur2
-- point suplémentaire pour le joueur 2
		local
			l_update: SQLITE_MODIFY_STATEMENT
		do
			l_point2:= l_point2+1
			create l_update.make ("UPDATE `pointage` SET `Points`=:POINT2 WHERE `Joueur` = 2;", l_db)
			check l_update_is_compiled: l_update.is_compiled end

			l_db.begin_transaction (False)
			l_update.execute_with_arguments ([create {SQLITE_INTEGER_ARG}.make (":POINT2", l_point2)])

			l_db.commit

		end
invariant
	database: l_db /= void
	Police: l_font /= void

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
