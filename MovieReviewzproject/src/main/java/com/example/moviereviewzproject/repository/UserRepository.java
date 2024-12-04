package com.example.moviereviewzproject.repository;

import com.example.moviereviewzproject.model.Review;
import com.example.moviereviewzproject.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface UserRepository extends JpaRepository<User, Integer> {
    List<User> findUserByEmail(int user_id);
}