package org.zerock.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.dto.AccountDTO;
import org.zerock.dto.AccountRole;
import org.zerock.mapper.AccountMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class AccountService {

    private final AccountMapper accountMapper;
    private final PasswordEncoder passwordEncoder;

    public void register(AccountDTO accountDTO) {
        log.info("register user : " + accountDTO.getUid());

        // Password encoding
        accountDTO.setUpw(passwordEncoder.encode(accountDTO.getUpw()));

        // Insert basic info
        accountMapper.insert(accountDTO);

        // Assign default role (USER)
        // If uname contains 'admin', assign ADMIN role as well (example logic)
        accountDTO.addRole(AccountRole.USER);

        if (accountDTO.getUid().toLowerCase().contains("admin")) {
            accountDTO.addRole(AccountRole.ADMIN);
        }

        // Insert roles
        accountMapper.insertRoles(accountDTO);
    }

    public AccountDTO get(String uid) {
        return accountMapper.selectOne(uid);
    }
}
