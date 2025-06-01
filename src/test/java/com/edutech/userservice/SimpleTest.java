package com.edutech.userservice;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
class SimpleTest {

    @Test
    void simpleTest() {
        // Verifica que el contexto de Spring se carga correctamente
        assertTrue(true, "La aplicación debería iniciarse correctamente");
    }
}
