note
	description: "wrapper vers les fonction SDL"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	SDL_WRAPPER

feature -- Functions -

	frozen SDL_Init (flags: NATURAL_32): INTEGER
			--int SDL_Init(Uint32 flags);
		external
			"C (Uint32) : int | <SDL.h>"
		alias
			"SDL_Init"
		end
	frozen SDL_LoadBMP (file: POINTER): POINTER
			--SDL_Surface *SDL_LoadBMP(const char *file);
		external
			"C (const char *) : SDL_Surface *| <SDL.h>"
		alias
			"SDL_LoadBMP"
		end

	frozen SDL_SetVideoMode (width, height, bitsperpixel:INTEGER; flags:NATURAL_32):POINTER
			--SDL_Surface* SDL_SetVideoMode(int width, int height, int bitsperpixel, Uint32 flags);
		external
			"C (int, int, int, Uint32):struct SDL_Surface * | <SDL.h>"
		alias
			"SDL_SetVideoMode"
		end

	frozen SDL_BlitSurface (src, srcrect, dst, dstrect: POINTER):INTEGER
			--int SDL_BlitSurface(SDL_Surface *src, SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect);

		external
			"C (struct SDL_Surface *, struct SDL_Rect *, struct SDL_Surface *, struct SDL_Rect *) : int | <SDL.h>"
		alias
			"SDL_BlitSurface"
		end

	frozen SDL_Flip (screen: POINTER):INTEGER
			--int SDL_Flip(SDL_Surface* screen);
		external
			"C (SDL_Surface *) : int | <SDL.h>"
		alias
			"SDL_Flip"
		end

	frozen SDL_Delay (ms: NATURAL_32)
			--void SDL_Delay(Uint32 ms);
		external
			"C (Uint32)| <SDL.h>"
		alias
			"SDL_Delay"
		end
	frozen SDL_PollEvent (event: POINTER):INTEGER
			--int SDL_PollEvent(SDL_Event *event);
		external
			"C (SDL_Event *) : int| <SDL.h>"
		alias
			"SDL_PollEvent"
		end
	frozen SDL_QuitEvent (event: POINTER):INTEGER
		--typedef struct{ Uint8 type } SDL_QuitEvent;
		external
			"C (SDL_Event *) : int| <SDL.h>"
		alias
			"SDL_PollEvent"
		end
feature -- Structure Setter

	frozen set_SDL_target_area_H (SDL_Rect: POINTER; value: INTEGER)
			-- Modifie le champ h de la structure `SDL_Surface' par la valeur `h'.
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Uint16)"
		alias
			"h"
	end

	frozen set_SDL_target_area_W (SDL_Rect: POINTER; value: INTEGER)
			-- Modifie le champ w de la structure `SDL_Surface' par la valeur `w'.
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Uint16)"
		alias
			"w"
	end

	frozen set_SDL_target_area_X (SDL_Rect: POINTER; value: INTEGER_16)
			-- Modifie le champ h de la structure `SDL_Surface' par la valeur `x'.
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Sint16)"
		alias
			"x"
	end

	frozen set_SDL_target_area_Y (SDL_Rect: POINTER; value: INTEGER_16)
			-- Modifie le champ w de la structure `SDL_Surface' par la valeur `y'.
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Sint16)"
		alias
			"y"
	end

 feature -- Structure Getter

	frozen get_bmp_h (SDL_Surface:POINTER):INTEGER
			-- Le champ h de la structure `SDL_Surface'
		external
			"C [struct <SDL.h>] (struct SDL_Surface): int"
		alias
			"h"
		end
	frozen get_bmp_w (SDL_Surface:POINTER):INTEGER
			-- Le champ w de la structure `SDL_Surface'
		external
			"C [struct <SDL.h>] (struct SDL_Surface): int"
		alias
			"w"
		end
	frozen get_SDL_EventType (SDL_Event:POINTER):NATURAL_8
		-- le type d'evènement du 'SDL_Event'
		external
			"C [struct <SDL.h>] (SDL_Event): Uint8"
		alias
			"type"
		end

	frozen get_SDL_EventKey (event:POINTER):POINTER
		-- la key de l'event
		external
			"C inline use <SDL.h>"
		alias
			"(SDL_KeyboardEvent *)(&(((SDL_Event *)$event)->key))"
		end

	frozen get_SDL_keysym (event:POINTER):POINTER
		-- le keysym de l'event
		external
			"C inline use <SDL.h>"
		alias
			"(SDL_keysym *)(&(((SDL_KeyboardEvent *)$event)->keysym))"
		end

	frozen get_SDL_sym (SDL_keysym:POINTER):NATURAL_8
		-- le sym du keysym
		external
			"C [struct <SDL.h>] (SDL_keysym): Uint8"
		alias
			"sym"
		end

feature --constantes

	frozen SDL_INIT_VIDEO:NATURAL_32
		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO"
		end

	frozen SDL_SWSURFACE:NATURAL_32
		external
			"C inline use <SDL.h>"
		alias
			"SDL_SWSURFACE"
		end

	frozen SDL_QUIT:NATURAL_8
		external
			"C inline use <SDL.h>"
		alias
			"SDL_QUIT"
		end

	frozen SDL_KEYDOWN:NATURAL_8
		external
			"C inline use <SDL.h>"
		alias
			"SDL_KEYDOWN"
		end
	frozen SDL_KEYUP:NATURAL_8
		external
			"C inline use <SDL.h>"
		alias
			"SDL_KEYUP"
		end

	frozen SDLK_UP:NATURAL_8
		external
			"C inline use <SDL_keysym.h>"
		alias
			"SDLK_UP"
		end
	frozen SDLK_DOWN:NATURAL_8
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_DOWN"
		end
	frozen SDLK_p:NATURAL_8
		external
			"C inline use <SDL.h>"
		alias
			"SDLK_p"
		end

feature --TTF WRAPPER
	frozen TTF_QUIT
		external
			"C inline use <SDL_ttf.h>"
		alias
			"TTF_Quit"
		end

	frozen TTF_CloseFont(font:POINTER)
		external
			"C inline use <SDL_ttf.h>"
		alias
			"TTF_CloseFont"
		end

	frozen TTF_INIT:INTEGER
		--int TTF_Init()
		external
			"C:int | <SDL_ttf.h>"
		alias
			"TTF_Init"
		end

	frozen TTF_OpenFont(file:POINTER; ptsize:INTEGER):POINTER
		external
			"C (const char *, Uint32): TTF_Font * | <SDL_ttf.h>"
		alias
			"TTF_OpenFont"
		end





	frozen set_SDL_color_r (SDL_color: POINTER; value: NATURAL_8)
			-- Set la valeur de rouge pour le SDL_Color utilisé avec RenderText_Font.
		external
			"C [struct <SDL.h>] (struct SDL_Color, Uint8)"
		alias
			"r"
	end

	frozen set_SDL_color_g (SDL_color: POINTER; value: NATURAL_8)
			-- Set la valeur de vert pour le SDL_Color utilisé avec RenderText_Font.
		external
			"C [struct <SDL.h>] (struct SDL_Color, Uint8)"
		alias
			"g"
	end

	frozen set_SDL_color_b (SDL_color: POINTER; value: NATURAL_8)
			-- Set la valeur de bleu pour le SDL_Color utilisé avec RenderText_Font.
		external
			"C [struct <SDL.h>] (struct SDL_Color, Uint8)"
		alias
			"b"
	end




	frozen TTF_RenderText_Solid(font, text, color:POINTER):POINTER
		--SDL_Surface *TTF_RenderUNICODE_Solid(TTF_Font *font, const Uint16 *text, SDL_Color fg);
		external
			"C inline use <SDL_ttf.h>"
		alias
			"TTF_RenderText_Solid((TTF_Font *)$font,(char *)$text, *(SDL_Color *)$color)"
		end

	frozen sizeof_SDL_Color:INTEGER
		external
			"C inline use <SDL_ttf.h>"
		alias
			"sizeof(SDL_Color *)"
		end




feature --mixer
	frozen Mix_Init(flags:INTEGER):INTEGER
		-- initialise le mixer
		external
			"C (int) : int | <SDL_mixer.h>"
		alias
			"Mix_Init"
		end
	frozen Mix_OpenAudio(frequency:INTEGER; format:NATURAL_16; channels:INTEGER; chunksize:INTEGER):INTEGER
		-- ouvre l'audio
		external
			"C (int, uint16, int, int) : int | <SDL_mixer.h>"
		alias
			"Mix_OpenAudio"
		end
	frozen Mix_LoadMUS(file:POINTER):POINTER
		-- ouvre le fichier de musique
		external
			"C (const char *) : Mix_Music * | <SDL_mixer.h>"
			alias
			"Mix_LoadMUS"
		end
	frozen Mix_PlayMusic(music:POINTER; loops:INTEGER):INTEGER
		-- fait jouer la musique et set le nombre de fois
		external
			"C inline use <SDL_mixer.h>"
			alias
			"Mix_PlayMusic((Mix_Music *)$music,(int)$loops)"
		end


feature --Wrapper de la souris
	frozen get_mouse_button (SDL_MouseButtonEvent:POINTER):NATURAL_8
		-- bouton de la souris selon l'event
		external
			"C [struct <SDL.h>] (SDL_MouseButtonEvent):Uint8 *"
		alias
			"button"
		end

	frozen get_mouse_y(SDL_MouseButtonEvent:POINTER):NATURAL_16
		-- y de la souris
		external
			"C [struct <SDL.h>] (SDL_MouseButtonEvent):Uint16 *"
		alias
			"y"
		end

	frozen get_mouse_x (SDL_MouseButtonEvent:POINTER):NATURAL_16
		-- x de la souris
		external
			"C [struct <SDL.h>] (SDL_MouseButtonEvent):Uint16 *"
		alias
			"x"
		end

	frozen SDL_MOUSEBUTTONDOWN:NATURAL_8
		--constante
		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONDOWN"
		end

feature -- Sizeof
	frozen sizeof_SDL_Rect:INTEGER
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(struct SDL_Rect)"
		end

	frozen sizeof_SDL_Event:INTEGER
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Event)"
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
