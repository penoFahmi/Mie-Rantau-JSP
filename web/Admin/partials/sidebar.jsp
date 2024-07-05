<%-- 
    Document   : sidebar
    Created on : 6 Jul 2024, 01.50.34
    Author     : Peno
--%>

      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="dashboard.jsp">
              <i class="mdi mdi-grid-large menu-icon"></i>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          
          <li class="nav-item nav-category">Aktivitas</li>     
          
          <li class="nav-item">
            <a class="nav-link" href="product.jsp">
              <i class="menu-icon mdi mdi-table"></i>
              <span class="menu-title">Produk</span>
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#transaksi" aria-expanded="false" aria-controls="charts">
              <i class="menu-icon mdi mdi-chart-line"></i>
              <span class="menu-title">Transaksi</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="transaksi">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="dashboard.jsp">Buttons</a></li>
                <li class="nav-item"> <a class="nav-link" href="dashboard.jsp">Dropdowns</a></li>
                <li class="nav-item"> <a class="nav-link" href="dashboard.jsp">Typography</a></li>
              </ul>
            </div>
          </li>
          
          <li class="nav-item nav-category">Profile</li>
          <li class="nav-item">
            <a class="nav-link" href="admin.jsp">
              <i class="menu-icon mdi mdi-account-circle-outline"></i>
              <span class="menu-title">Admin</span>
            </a>
          </li>
        </ul>
      </nav>