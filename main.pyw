from PySide import QtCore, QtGui, QtDeclarative


class MainWnd(QtGui.QMainWindow):
    def __init__(self, parent=None):
        super(MainWnd, self).__init__(parent)

        self.layout = QtGui.QHBoxLayout()

        qmlView = QtDeclarative.QDeclarativeView()
        qmlView.setSource(QtCore.QUrl('main.qml'))
        qmlView.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)

        self.layout.addWidget(qmlView)

        centralWidget = QtGui.QWidget()
        centralWidget.setLayout(self.layout)

        self.setCentralWidget(centralWidget)


if __name__ == '__main__':
    import sys

    app = QtGui.QApplication(sys.argv)
    form = MainWnd()

    form.show()

    sys.exit(app.exec_())
