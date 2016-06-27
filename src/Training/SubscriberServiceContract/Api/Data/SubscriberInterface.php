<?php

namespace Training\SubscriberServiceContract\Api\Data;

interface SubscriberInterface
{

    public function getId();

    public function getName();

    public function getEmail();

    public function getComment();

    public function getCreatedAt();

    public function getUpdatedAt();

    public function setName($name);

    public function setEmail($email);

    public function setComment($comment);
}