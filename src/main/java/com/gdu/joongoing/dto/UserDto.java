package com.gdu.joongoing.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class UserDto {
  private int userNo;
  private String email;
  private String name;
  private String pw;
  private String gender;
  private String phone;
  private int agree;
  private int state;
  private Timestamp joinedAt;
  private String sido;
  private String sigungu;
  private String interestSido;
  private String interestSigungu;
}