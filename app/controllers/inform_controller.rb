# coding: utf-8
class InformController < ApplicationController
  def toukou
    hatsugen_=tmp_h=params[:ht1]
    re_id_=tmp_id=params[:re_id]

    if tmp_id.size==0  #re_idがNULLの場合通常発言,発言idの場合は返信
      re_id_=nil
    end

    if tmp_h.size ==0 || (tmp_h.gsub(/\r\n|\r|\n|\s|\t/, "")).size==0 #空白文字か、空文字ならNULLとする
      hatsugen_= nil
    end

   Comment.create(message:hatsugen_,re_id:re_id_,acc_id:"kari")
    Comment.where(message:nil,re_id:nil).destroy_all

  end
  def nakenashi
    end
  end
