#!/usr/bin/python
# -*- coding: utf-8 -*-

from sqlalchemy import Column, Integer, String, Table, ForeignKey
from sqlalchemy.orm import relationship
from database import Base


book_to_authors = Table('book_to_authors', Base.metadata,
    Column('left_id', Integer, ForeignKey('books.id')),
    Column('right_id', Integer, ForeignKey('authors.id'))
)


class Author(Base):
    __tablename__ = 'authors'
    id = Column(Integer, primary_key=True)
    name = Column(String(100), unique=True)

    def __init__(self, name=None):
        self.name = name

    def __repr__(self):
        return '<Author %r>' % (self.name)


class Book(Base):
    __tablename__ = 'books'
    id = Column(Integer, primary_key=True)
    title = Column(String(100), unique=True)
    authors = relationship("Author", secondary=book_to_authors)

    def __init__(self, title=None):
        self.title = title

    def __repr__(self):
        return '<Book %r>' % (self.title)
