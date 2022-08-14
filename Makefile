SRC = srcs/docker-compose.yml
NAME = inception

all : ${NAME}

${NAME} :
	mkdir -p /home/heom/data/wordpress
	mkdir -p /home/heom/data/mysql
	sudo docker-compose -f ${SRC} up --build -d

clean :
	sudo docker-compose -f ${SRC} down --rmi all

fclean :
	sudo bash cleanup.sh

hosts:
	echo "127.0.0.1 heom.42.fr" >> /etc/hosts

re : fclean all

.PHONY: hosts re all fclean clean
