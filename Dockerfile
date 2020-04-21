ARG IMAGE=store/intersystems/irishealth:2019.3.0.308.0-community
ARG IMAGE=store/intersystems/iris-community:2019.3.0.309.0
ARG IMAGE=store/intersystems/iris-community:2019.4.0.379.0
ARG IMAGE=store/intersystems/iris-community:2020.1.0.199.0
# ARG IMAGE=intersystemsdc/iris-community:2019.4.0.383.0-zpm
FROM $IMAGE

USER root
COPY irisapp/webix /usr/irissys/csp/irisapp/webix
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER irisowner

COPY  Installer.cls .
COPY  src src
COPY irissession.sh /
COPY irisapp/webix /usr/irissys/csp/user/codebase

SHELL ["/irissession.sh"]

RUN \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup() \
  do ##class(App.Installer).RestWebApp() \
  do ##class(App.Installer).ModifyIrisapp()

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
