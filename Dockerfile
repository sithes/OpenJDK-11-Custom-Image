# Red Hat OpenJDK 11 JRE with Conjur summon config image
# The official Red Hat registry and the base image
FROM registry.access.redhat.com/ubi8/ubi-minimal
MAINTAINER sithes.nmc@gmail.com
# Install OpenJDK 11
RUN microdnf --setopt=tsflags=nodocs install -y java-11-openjdk \
	&& rm -rf /var/cache/yum \
	&& microdnf clean all \
	&& echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/conf/security/java.security \
	&& curl -L >summon.tar.gz https://github.com/cyberark/summon/releases/download/v0.8.3/summon-linux-amd64.tar.gz \
	&& gzip -d summon.tar.gz > /usr/local/bin/summon \
	&& chmod 755 /usr/local/bin/summon \
	&& mkdir /usr/local/lib/summon/ \
	&& curl -L >summon-conjur.tar.gz https://github.com/cyberark/summon-conjur/releases/download/v0.5.3/summon-conjur-linux-amd64.tar.gz \
	&& gzip -d summon-conjur.tar.gz > /usr/local/lib/summon/summon-conjur \
	&& chmod 755 /usr/local/lib/summon/summon-conjur
# Set the JAVA_HOME variable to make it clear where Java is located
ENV \
	JAVA_HOME="/usr/lib/jvm/java-11" \
	JAVA_VENDOR="openjdk" \
	JAVA_VERSION="11" \
	TZ="Asia/Singapore"
LABEL \
	com.redhat.component="openjdk-11-ubi8-container"  \
	com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI"  \
	description="Source To Image (S2I) image for Red Hat OpenShift providing OpenJDK 11"  \
	io.cekit.version="3.6.0"  \
	io.k8s.description="Platform for building and running plain Java applications (fat-jar and flat classpath)"  \
	io.k8s.display-name="Java Applications"  \
	io.openshift.tags="builder,java"  \
	maintainer="Red Hat OpenJDK <openjdk@redhat.com>"  \
	name="ubi8/openjdk-11"  \
	summary="Source To Image (S2I) image for Red Hat OpenShift providing OpenJDK 11"  \
	usage="https://access.redhat.com/documentation/en-us/red_hat_jboss_middleware_for_openshift/3/html/red_hat_java_s2i_for_openshift/"  \
	version="1.3" \
	summon="https://github.com/cyberark/summon/releases/download/v0.8.3/summon-linux-amd64.tar.gz" \
	summon-conjur="https://github.com/cyberark/summon-conjur/releases/download/v0.5.3/summon-conjur-linux-amd64.tar.gz"
