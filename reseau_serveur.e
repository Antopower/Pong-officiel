note
	description: "création et gestion de la communication réseau serveur"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	RESEAU_SERVEUR

create
	creer_reseau
feature

		l_serveur_address, l_client_address: NETWORK_SOCKET_ADDRESS
		l_serveur_socket:  NETWORK_STREAM_SOCKET
		l_client_socket: NETWORK_STREAM_SOCKET

	creer_reseau
	-- création du serveur
		local
			l_port:INTEGER
			on:BOOLEAN
		do
			l_port := 12345
--			io.put_string ("Ouverture du serveur sur le port: "+l_port.out+".%N")
			create l_serveur_socket.make_server_by_port (l_port)
			l_serveur_address:=l_serveur_socket.address
--			io.put_string ("Socket ouvert et en ecoute sur l'adresse:"+l_serveur_address.host_address.host_address+":"+l_serveur_address.port.out+".%N")
			l_serveur_socket.listen (1)
			l_serveur_socket.accept
			l_client_socket:=l_serveur_socket.accepted
--			l_client_address:=l_client_socket.peer_address
--			io.put_string ("Connexion établie!(Serveur)")

--			l_client_socket.put_integer_16 (300)
		end
	envoyer(l_barre2:FORME_OBJET)
	-- envoi du Y au client
		do
--			io.put_string ("envoi")
        	l_client_socket.put_integer_16 (l_barre2.y)
   		end
   	recevoir:INTEGER_16
   	-- réception du Y du client
   		do
--   		io.put_string ("reception")
   			l_client_socket.read_integer_16
   			result := l_client_socket.last_integer_16
   		end
	close_reseau
	-- fermeture du serveur
		do
			l_client_socket.close
			l_serveur_socket.close
		end

invariant
	adresses: l_serveur_address /= void and l_client_address /= void
	sockets: l_serveur_socket /= void and l_client_socket /= void
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
