note
	description: "gère l'affichage de tous les formes_objets"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	IMAGE

feature -- Access
	-- affichage de la forme envoyée en paramètre
	afficher(l_window:POINTER l_forme:FORME_OBJET)
		local
			l_blit_surface:INTEGER
		do
			{SDL_WRAPPER}.set_SDL_target_area_H(l_forme.target_area, {SDL_WRAPPER}.get_bmp_h(l_forme.l_bmp))
			{SDL_WRAPPER}.set_SDL_target_area_W(l_forme.target_area, {SDL_WRAPPER}.get_bmp_w(l_forme.l_bmp))
			{SDL_WRAPPER}.set_SDL_target_area_X(l_forme.target_area, l_forme.X)
			{SDL_WRAPPER}.set_SDL_target_area_Y(l_forme.target_area, l_forme.Y)

			l_blit_surface := {SDL_WRAPPER}.SDL_BlitSurface(l_forme.l_bmp, create {POINTER}, l_window, l_forme.target_area)
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
