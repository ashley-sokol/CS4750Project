package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findUserByEmail(String user_email);
    Void updateUserByUserID(long user_id);
}
