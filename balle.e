note
	description: "balle du jeu, toujours utilis� dans d�placement et dans game"
	author: "Anthony Martel et �tienne Boisjoli"
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
		-- cr�ation de la balle avec les valeurs de d�part
		do
			creer_forme(l_X, l_Y, "Ressources/balle_jeu.bmp")
			droite := true
			vitesse := 30
		end

		set_vitesse(l_vitesse_temp:INTEGER_16)
		-- change la vitesse selon le param�tre
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
	copyright: "Copyright (c) 2012-2013, �tienne Boisjoli et Anthony Martel"
	license: "AGPL 3.0 (see http://www.gnu.org/licenses/agpl.txt)"
	source: "[
		�tienne Boisjoli et Anthony Martel
		�tudiants
		C�gep de Drummondville
		960, rue Saint-Georges
		Drummondville, (Qu�bec)
		J2C-6A2
		Telephone 819 478-4671, Fax 819 474-6859
		Site Web http://www.cdrummond.qc.ca
	]"
end
