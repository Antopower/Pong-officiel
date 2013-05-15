note
	description: "balle du jeu, toujours utilisé dans déplacement et dans game"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	BALLE

inherit
	FORME_OBJET

	IMAGE
create
	creer_balle

feature -- Access
		vitesse:INTEGER_16
		monte, droite:BOOLEAN


		creer_balle(l_X:INTEGER_16 l_Y:INTEGER_16)
		-- création de la balle avec les valeurs de départ
		do
			creer_forme(l_X, l_Y, "Ressources/balle_jeu.bmp")
			droite := true
			vitesse := 30
		end

		set_vitesse(l_vitesse_temp:INTEGER_16)
		-- change la vitesse selon le paramètre
			do
				vitesse := l_vitesse_temp
			end
		set_monte(l_monte_temp:BOOLEAN)
		-- change le flag pour que la balle monte
			do
				monte := l_monte_temp
			end
		set_droite(l_droite_temp:BOOLEAN)
		-- change le flag pour que la balle aille a droite
			do
				droite := l_droite_temp
			end
invariant
	Vitesse_est_positive: vitesse > 0

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
