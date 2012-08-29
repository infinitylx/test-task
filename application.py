#!/usr/bin/python
# -*- coding: utf-8 -*-

from flask import Flask
from database import db_session, init_db
from models import Author, Book
from flask import redirect, url_for, request, render_template
app = Flask(__name__)
init_db()


@app.teardown_request
def shutdown_session(exception=None):
    db_session.remove()


@app.route('/')
def show_all():
    authors = Author.query.all()
    books = Book.query.all()

    return render_template('index.html', authors=authors, books=books)


@app.route('/book/')
@app.route('/book/<int:book_id>/')
def show_book(book_id=None):
    books = Book.query.all()
    book = Book.query.filter(Book.id == book_id).first()

    return render_template('book.html', book=book, books=books)


@app.route('/author/')
@app.route('/author/<int:author_id>/')
def show_authors(author_id=None):
    authors = Author.query.all()
    author = Author.query.filter(Author.id == author_id).first()

    return render_template('author.html', authors=authors, author=author)


@app.route('/book/add/', methods=['GET', 'POST'])
def add_book():

    if request.method == "GET":

        return render_template('add_book.html', authors=Author.query.all())

    book = Book(request.form['title'])
    author = Author.query.filter(Author.id == request.form['author']).first()
    book.authors.append(author)

    db_session.add(book)
    db_session.commit()

    return redirect(url_for('show_book', book_id=book.id))


@app.route('/author/add/', methods=['GET', 'POST'])
def add_author():

    if request.method == 'GET':

        return render_template('add_author.html')

    author = Author(request.form['name'])

    db_session.add(author)
    db_session.commit()

    return redirect(url_for('show_authors', author_id=author.id))


@app.route('/book/<int:book_id>/edit/', methods=['GET', 'POST'])
def edit_book(book_id):

    book = Book.query.filter(Book.id == book_id).first()

    if request.method == "GET":

        return render_template('edit_book.html', authors=Author.query.all(), book=book)

    book.title = request.form['title']
    book.authors = [Author.query.filter(Author.id == a).first() \
                    for a in request.form.getlist('author')]

    db_session.commit()

    return redirect(url_for('show_book', book_id=book.id))


@app.route('/author/<int:author_id>/edit/', methods=['GET', 'POST'])
def edit_author(author_id):
    author = Author.query.filter(Author.id == author_id).first()

    if request.method == 'GET':

        return render_template('edit_author.html', author=author)

    author.name = request.form['name']

    db_session.commit()

    return redirect(url_for('show_authors', author_id=author.id))


@app.route('/search/', methods=['POST'])
def search():

    authors = Author.query.filter(Author.name == request.form['question']).all()
    books = Book.query.filter(Book.title == request.form['question']).all()

    return render_template('search.html', books=books, authors=authors)


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

if __name__ == '__main__':
    # this is only for debugging.
    # app.debug = True
    app.run()
