package com.example.moviereviewzproject.controller;

import com.example.moviereviewzproject.model.*;
import com.example.moviereviewzproject.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
//User API should include creating, deleting, or updating a user's email or password,

@CrossOrigin
@RestController
@RequestMapping("/api")
public class UserController {
    @Autowired
    UserRepository userRepository;

    @PostMapping("/user")
    public ResponseEntity<User> createPatient(@RequestBody User user) {
           if (userRepository.findUserByEmail(user.getUserEmail()) != null)
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
           User createdUser = userRepository.save(user);
        return new ResponseEntity<>(createdUser, HttpStatus.CREATED);
    }

    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllUsers(@RequestParam(required = false) String email) {
        try {
            List<User> users = new ArrayList<User>();

            if (email == null)
                userRepository.findAll().forEach(users::add);
            else
                userRepository.findUserByEmail(email).forEach(users::add);

            if (users.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            return new ResponseEntity<>(users, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    

}
