package com.bigtreetc.sample.domain

import org.springframework.test.context.DynamicPropertyRegistry
import org.springframework.test.context.DynamicPropertySource
import org.testcontainers.containers.GenericContainer
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.containers.wait.strategy.Wait
import org.testcontainers.spock.Testcontainers
import org.testcontainers.utility.DockerImageName
import spock.lang.Specification

@Testcontainers
class BaseTestContainerSpec extends Specification {

    static final PostgreSQLContainer<?> POSTGRESQL_CONTAINER = new PostgreSQLContainer<>(DockerImageName.parse("postgres:16-alpine"))

    static final GenericContainer<?> MAILHOG_CONTAINER =
            new GenericContainer<>("mailhog/mailhog")
                    .withExposedPorts(1025, 8025)
                    .waitingFor(Wait.forHttp("/").forPort(8025))

    @DynamicPropertySource
    static void overrideProperties(DynamicPropertyRegistry registry) {
        POSTGRESQL_CONTAINER.start()
        MAILHOG_CONTAINER.start()

        registry.add(
                "spring.datasource.url",
                () ->
                        "jdbc:postgresql://%s:%d/%s"
                                .formatted(
                                        POSTGRESQL_CONTAINER.getHost(),
                                        POSTGRESQL_CONTAINER.getFirstMappedPort(),
                                        POSTGRESQL_CONTAINER.getDatabaseName()))
        registry.add("spring.datasource.username", POSTGRESQL_CONTAINER::getUsername)
        registry.add("spring.datasource.password", POSTGRESQL_CONTAINER::getPassword)
        registry.add("spring.flyway.url", POSTGRESQL_CONTAINER::getJdbcUrl)
        registry.add("spring.flyway.user", POSTGRESQL_CONTAINER::getUsername)
        registry.add("spring.flyway.password", POSTGRESQL_CONTAINER::getPassword)

        registry.add("spring.mail.host", MAILHOG_CONTAINER::getHost)
        registry.add("spring.mail.port", MAILHOG_CONTAINER::getFirstMappedPort)
    }

    def cleanupSpec() {
        POSTGRESQL_CONTAINER.stop()
        MAILHOG_CONTAINER.stop()
    }
}
