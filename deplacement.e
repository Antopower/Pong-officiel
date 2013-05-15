note
	description: "déplacement: gère les déplacements de la balle et des barres"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	DEPLACEMENT

feature
	bouton_presse(l_event:POINTER l_barre:FORME_OBJET)
	-- effectue les déplacements appropriés de la barre selon l'event envoyé en paramètre
		local
			l_keyboard_event, l_keysym:POINTER
		do
			l_keyboard_event := {SDL_WRAPPER}.get_SDL_EventKey(l_event)
			l_keysym := {SDL_WRAPPER}.get_SDL_keysym(l_keyboard_event)
			if----- key down
				{SDL_WRAPPER}.get_SDL_sym(l_keysym) = {SDL_WRAPPER}.SDLK_DOWN
			then
				if
					l_barre.y < 500
				then
					l_barre.set_player1_Y(10)
				end

			end
			if---- key up
				{SDL_WRAPPER}.get_SDL_sym(l_keysym) = {SDL_WRAPPER}.SDLK_UP
			then
				if
					l_barre.Y > 20
				then
					l_barre.set_player1_Y(-10)
				end
			end
	end

	balle(l_balle:BALLE l_barre1:FORME_OBJET l_barre2:FORME_OBJET)
		-- déplace la balle selon ses variables (monte, droite, vitesse)
		local
			l_colision_32:INTEGER_32
		do  ---vérifications du sens
			if
				l_balle.droite
			then
			-- si elle va a droite
				if
					l_balle.X+l_balle.vitesse > 1220
				then
					----- colision centre de la barre
					if
						l_balle.y >= l_barre2.y + 50 and l_balle.y +30 <= l_barre2.y +150
					then
						l_colision_32 := l_balle.X-(1220-(l_balle.vitesse-(1220-l_balle.X)))
						l_balle.set_x(l_colision_32.as_integer_16)
						l_balle.set_droite (false)
					end
					---- colision section du haut
					if
						l_balle.y + 30 >= l_barre2.y and l_balle.y < l_barre2.y+50
					then
						l_colision_32 := l_balle.X-(1220-(l_balle.vitesse-(1220-l_balle.X)))
						l_balle.set_x(l_colision_32.as_integer_16)
						l_balle.set_droite (false)
						l_balle.set_monte (true)
					end
					---- colision section du bas
					if
						l_balle.y +30 > l_barre2.y +150 and l_balle.y <= l_barre2.y +200
					then
						l_colision_32 := l_balle.X-(1220-(l_balle.vitesse-(1220-l_balle.X)))
						l_balle.set_x(l_colision_32.as_integer_16)
						l_balle.set_droite (false)
						l_balle.set_monte (false)
					end
				end
			end
			if
				l_balle.droite = false
			then
			-- si elle va a gauche
				if
					l_balle.X-l_balle.vitesse < 30
				then
					---- colision centre de la barre
					if
						l_balle.y >= l_barre1.y + 50 and l_balle.y +30 <= l_barre1.y +150
					then
						l_colision_32 := l_balle.X-(30+(l_balle.vitesse-(l_balle.X-30)))
						l_balle.set_x (l_colision_32.as_integer_16)
						l_balle.set_droite (true)
					end
					---- colision section du haut
					if
						l_balle.y + 30 >= l_barre1.y and l_balle.y < l_barre1.y+50
					then
						l_colision_32 := l_balle.X-(30+(l_balle.vitesse-(l_balle.X-30)))
						l_balle.set_x (l_colision_32.as_integer_16)
						l_balle.set_droite (true)
						l_balle.set_monte (true)
					end
					---- colision section du bas
					if
						l_balle.y +30 > l_barre1.y +150 and l_balle.y <= l_barre1.y +200
					then
						l_colision_32 := l_balle.X-(30+(l_balle.vitesse-(l_balle.X-30)))
						l_balle.set_x (l_colision_32.as_integer_16)
						l_balle.set_droite (true)
						l_balle.set_monte (false)
					end
				end
			end



			if
				l_balle.monte
			then
				--si elle monte
				if--colision avec le mur du haut
					l_balle.y-l_balle.vitesse < 30
				then
					l_balle.set_monte (false)
				end
			end

			if
				l_balle.monte = false
			then
				--si elle descend
				if--colision avec le mur du bas
					l_balle.Y+l_balle.vitesse > 670
				then
					l_balle.set_monte (true)
				end
			end

			--dépalcements apres calcul des colisions
			 if
			 	l_balle.droite
			 then
			 	l_balle.set_x (l_balle.vitesse)
			 end
			 if
			 	l_balle.droite = false
			 then
			 	l_balle.set_x (-l_balle.vitesse)
			 end

			 if
			 	l_balle.monte
			 then
			 	l_balle.set_player1_Y (-l_balle.vitesse)
			 end
			 if
			 	l_balle.monte = false
			 then
			 	l_balle.set_player1_Y (l_balle.vitesse)
			 end
		end
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
