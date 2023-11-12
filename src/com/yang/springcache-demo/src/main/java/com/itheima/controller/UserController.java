package com.itheima.controller;

import com.itheima.entity.User;
import com.itheima.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@Slf4j
public class UserController {

    @Autowired
    private UserMapper userMapper;

    @PostMapping
    @CachePut(cacheNames = "userCache", key = "#user.id")
    /**
     * 其他的写法
     *  @CachePut(cacheNames = "userCache",key = "#result.id")
     *  @CachePut(cacheNames = "userCache",key = "#p0.id") 0表示第一个
     *  @CachePut(cacheNames = "userCache",key = "#a0.id") 0表示第一个
     *  @CachePut(cacheNames = "userCache",key = "#root.args[0].id") args[0]表示第一个
     */
    public User save(@RequestBody User user) {
        userMapper.insert(user);
        return user;
    }

    @GetMapping
    @Cacheable(cacheNames = "userCache", key = "#id")
    public User getById(Long id) {
        User user = userMapper.getById(id);
        return user;
    }

    @DeleteMapping
    @CacheEvict(cacheNames = "userCache", key = "#id")
    public void deleteById(Long id) {
        userMapper.deleteById(id);
    }

    @DeleteMapping("/delAll")
    @CacheEvict(cacheNames = "userCache", allEntries = true)
    public void deleteAll() {
        userMapper.deleteAll();
    }

}
