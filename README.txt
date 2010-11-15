vzenter: extremely simple tool which allows you to enter an OpenVZ 
         container (vzctl enter) specifying a minimal noncontradictory 
         part of its domain name 
(C) dkLab, http://en.dklab.ru/lib/dklab_vzenter/


dklab_vzenter is a simple tool for system administrators which allows 
you to enter an OpenVZ container (vzctl enter) specifying a minimal 
noncontradictory part of its domain name. Now you do not need to 
memorize CTID or use vzlist very often. 


INSTALLATION
------------

cd /usr/sbin 
wget https://github.com/DmitryKoterov/dklab_vzenter/raw/master/e 
chmod +x e


SYNOPSIS
--------

Assume you have the following 4 containers in your host system:

110   web-a-01.pr.example.com
111   web-a-02.pr.example.com
310   ns1.example.com
210   test.pr.example.com

Let's consider how e command (shorten spelling of dklab_vzenter) works: 

# e web-a-01
Entering web-a-01.pr.example.com
entered into CT 110

# e w1
Entering web-a-01.pr.example.com
entered into CT 110

# e w2
Entering web-a-02.pr.example.com
entered into CT 111

# e ns
Entering ns1.example.com
entered into CT 310

# e test
Entering test.pr.example.com
entered into CT 210

# e 110
Entering web-a-01.pr.example.com
entered into CT 110

You see, dklab_vzenter tries to find names which includes typed characters in 
their order, but not necessarily successively. Now let's see what would happen 
if more than one matches are found:

# e web
More than one match found, please detalise:
  110  web-a-01.pr.example.com
  111  web-a-02.pr.example.com

So, you may enter a container only typing a noncontradictory part of its domain 
name or its CTID. 
