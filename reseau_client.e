note
	description: "création et gestion de la communication réseau client"
	author: "Anthony Martel et Étienne Boisjoli"
	date: "11 mai 2013"
	revision: "Beta 1.4"

class
	RESEAU_CLIENT
create
	creer_client
feature -- Initialization+

	l_socket: NETWORK_STREAM_SOCKET

    creer_client
    --connection au serveur
        local
            l_addr_factory:INET_ADDRESS_FACTORY
            l_address:INET_ADDRESS
            l_addr:STRING
            l_port:INTEGER
        do
            create l_addr_factory
            l_addr:="192.168.0.107"
            l_port:=12345

            io.put_string ("Ouverture du client. Adresse: "+l_addr+", port: "+l_port.out+".%N")

            l_address:= l_addr_factory.create_from_name (l_addr)
            create l_socket.make_client_by_address_and_port (l_address, l_port)
            l_socket.connect
            io.put_string ("Connexion établie!(Client)")
--           l_socket.put_integer_16 (300)

		end
	envoyer(l_barre2:FORME_OBJET)
	--envoi du Y au serveur
		do
--			io.put_string ("envoi")
        	l_socket.put_integer_16 (l_barre2.y)
   		end
   	recevoir:INTEGER_16
   	-- reception du Y du serveur
   		do
--   		io.put_string ("reception")
   			l_socket.read_integer_16
   			result := l_socket.last_integer_16
   		end
   	fin
   		do
   			l_socket.close --mettre a la fin
   		end
invariant
	socket: l_socket /= void

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
