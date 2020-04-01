ARG IMAGE=store/intersystems/irishealth:2019.3.0.308.0-community
ARG IMAGE=store/intersystems/iris-community:2019.3.0.309.0
ARG IMAGE=store/intersystems/iris-community:2019.4.0.379.0
ARG IMAGE=store/intersystems/iris-community:2020.1.0.199.0
ARG IMAGE=intersystemsdc/iris-community:2019.4.0.383.0-zpm
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER irisowner

COPY  Installer.cls .
COPY  src src
COPY irissession.sh /
COPY webix_samples /usr/irissys/csp/user/samples
COPY webix_codebase /usr/irissys/csp/user/codebase
COPY webix_codebase /usr/irissys/csp/irisapp/webix
SHELL ["/irissession.sh"]

RUN \
  do $SYSTEM.OBJ.Load("Installer.cls", "ck") \
  set sc = ##class(App.Installer).setup() \
  zn "%SYS" \
  write "Create web application ..." \
  set webName = "/api" \
  set webProperties("DispatchClass") = "Api.Rest" \
  set webProperties("NameSpace") = "IRISAPP" \
  set webProperties("Enabled") = 1 \
  set webProperties("AutheEnabled") = 64 \
  set webProperties("MatchRoles")=":%DB_IRISAPP" \
  set sc = ##class(Security.Applications).Create(webName, .webProperties) \
  write sc \
  write:sc "Web application "_webName_" has been created!"

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
