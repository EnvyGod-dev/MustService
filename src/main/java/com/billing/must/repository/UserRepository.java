package com.billing.must.repository;

import com.billing.must.model.User;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @Query("SELECT u FROM User u WHERE u.name = ?1")
    List<User> findByName(String name);

    @Modifying
    @Transactional
    @Query(
            value = "INSERT INTO users (name, email, password, role) VALUES (?1, ?2, ?3, ?4)",
            nativeQuery = true)
    void insertUser(String name, String email, String password, String role);
}
